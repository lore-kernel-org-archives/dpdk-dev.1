Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C925606A320
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Nov 2026 10:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EodYw1gH
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1EB87402F0;
	Fri, 20 Nov 2026 11:13:18 +0100 (CET)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com
 [209.85.167.45])
 by mails.dpdk.org (Postfix) with ESMTPS id BB24040151
 for <dev@dpdk.org>; Thu, 19 Nov 2026 19:15:40 +0100 (CET)
Received: by mail-lf1-f45.google.com with SMTP id
 2adb3069b0e04-5c14f3dab0cso1875219e87.1
 for <dev@dpdk.org>; Thu, 19 Nov 2026 10:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795112139; x=1795716939; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PR52FReZCRZGasEQZVyaOFt2fmAs2vz9p8fgavP9wuo=;
 b=EodYw1gHSuZ8i7FZ1lF5RMncoeaoVGhPwkmQVQZmGeoYauYVl3+EugrqD+DxnlZHJA
 7lVxtYMf7f/0cES/6I/GR6mM+9tsbuJLICEc8mliH30UM49gTgXgIE5NHTpdNq4i/28G
 HqC3letgUwL7myiEdKbLkm477RTjTOrH0bJENEgpHd5HaZ/FqMs3yNU2NJX62J9BHCJg
 /Fqez3A1jyarTgQBGDzODyoXnmVihh9pTaEHy15ZIe0PZ4FmSRXpK01hBpwH5qa9rc85
 nV/JdJU4Z0xAZ3DIrWpp1A17oDzg64lSeaEEJCmy7g93OKE/QQOPH6ETDEJ5i1Qv79e2
 2Qsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795112139; x=1795716939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PR52FReZCRZGasEQZVyaOFt2fmAs2vz9p8fgavP9wuo=;
 b=1/qEwgM2ew4RhWJbyFghdMXBX39NQtMSlXNXFXz1RzYX8DhNsXvOanCzQHNDbQPsay
 0+jFu2ew+2K5FsQE821o0i03wIODtCohBhqBO7g3rtQdHoShKliuZG9ZoeMkfsbGHHRg
 B6UaKz4Lxt7jYK+0F6XL3G+JuWqiqo0i/duiFm07FOkIa3lslu3mIgW9kazUy9Ap5mh7
 s3FNEJSnJzlSRAEFAybNdax3rmXq+7xel+Tvshc+uFUt5IC365aU1ESilOZ0gG50gzgz
 WlvckZ0m7oX6wNbu8d8hOZHA/WpjjLfq8Ci+g7A0cA71ybdWedVpiWgctfJfHwWGHyOd
 01qA==
X-Gm-Message-State: APuU4Z+UPq/1bs7yLLsCzGdTaY5LrNrJ3xUbEhhP9mdWETlE41LOeoPU
 MsehMuZ3Ujdf+fsnhBLXdoCUvZ98NKny7jTQ8HD5kQnSgeQOF4Qmzfh0
X-Gm-Gg: AYBFou2bseMOvERWe84tTnhCchgd7vvbIsGW6yoG288LRhuZSAs3eDWZCfOJ0oYUbO6
 URIbDFy/jqrhraV2HlPXgAg5LnDaDv8PaCXdaIvuDGywGsGfC+PRwLJcSf79QetiU1/xsigpis5
 bXnuASaQYPuE3AaOs6RTsBxh3/c8hXHCBAKRk3RDcrM4VAhiijUO1VeBPNZFO4zi8rGLxOkmbF4
 Z451r+HYt8MUGmaDuBwL60CN/Gxyu6BeDxF08PRzRkAFPP6ljHxXxnSJ8d3EUSDbhbTqRlHwc3s
 GFKV9VMyYbGSoUGFMOvpTu8JphjWNFGIYa1AzFWXGQappev9k/7KR4Cg/EBx99MhnBi8B/9DSdJ
 JNVjqourdIR5VZS5Q8CvvfdF2Mi+N6El2R3EmHFIDORVGosBDxXaYeudvywWiMx82ImGuKpKbAx
 p212f3IwBD/YdZenIg73yRaiGqlrCFWSmfrKvuws3iBTY86tSTfxvHDlhIYo7Um7iInmhUNScUM
 IJiPlTZDORhnXjdkrbOXzTI8638xXzvQ5ChCRPDI9oQyWVDMN3F8fEd2BLz3NirDKfsqzo9ls7A
 D9VXxCZ+Qj78m9Ztx5P63ZuVemXQSSAlTlGTl/ri9pXjQCDWIg==
X-Received: by 2002:a05:6512:2387:b0:5c1:4a79:b9c1 with SMTP id
 2adb3069b0e04-5c1bc844b9dmr144395e87.22.1795112139314; 
 Thu, 19 Nov 2026 10:15:39 -0800 (PST)
Received: from localhost.localdomain ([213.24.125.164])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5c1bd041813sm32494e87.53.2026.11.19.10.15.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 10:15:38 -0800 (PST)
From: Mark Bulatov <ms.bulatov7@gmail.com>
To: Chaoyong He <chaoyong.he@corigine.com>,
 =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@corigine.com>
Cc: dev@dpdk.org,
	stable@dpdk.org,
	Mark Bulatov <ms.bulatov7@gmail.com>
Subject: [PATCH v3] net/nfp: fix uninit local var in
 nfp_pre_tun_table_check_del
Date: Thu, 19 Nov 2026 21:15:27 +0300
Message-Id: <20261119181527.5195-1-ms.bulatov7@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261116171857.5306-1-ms.bulatov7@gmail.com>
References: <20261116171857.5306-1-ms.bulatov7@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 20 Nov 2026 11:13:15 +0100
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

find_entry is left uninitialized if no pre-tunnel slot is in
use, and is NULL if no slot matches this representor's MAC.
Either case is then dereferenced when computing nfp_mac_idx.

Initialize find_entry and fail the delete if no entry is found.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: d3c33bdf1f18 ("net/nfp: prepare for IPv4 UDP tunnel decap flow action")
Cc: stable@dpdk.org

Signed-off-by: Mark Bulatov <ms.bulatov7@gmail.com>
---
v3 changes: The check was moved to a higher level, and
the description was corrected.

v2 link:
https://patches.dpdk.org/project/dpdk/patch/20261116171857.5306-1-ms.bulatov7@gmail.com/
v2 changes: Correction of the Fixes tag and addition of find_entry
initialization at the point of declaration

v1 link:
https://patches.dpdk.org/project/dpdk/patch/20261113142207.5537-1-ms.bulatov7@gmail.com/

 drivers/net/nfp/flower/nfp_flower_flow.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/nfp/flower/nfp_flower_flow.c b/drivers/net/nfp/flower/nfp_flower_flow.c
index ad0fe9a8ef..9dbf9b934a 100644
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
@@ -3827,6 +3827,12 @@ nfp_pre_tun_table_check_del(struct nfp_flower_representor *repr,
 		}
 	}
 
+	if (find_entry == NULL) {
+		PMD_DRV_LOG(ERR, "Pre-tunnel table entry not found.");
+		ret = -EINVAL;
+		goto free_entry;
+	}
+
 	nfp_flow_meta = nfp_flow->payload.meta;
 	nfp_mac_idx = (find_entry->mac_index << 8) |
 			NFP_FLOWER_CMSG_PORT_TYPE_OTHER_PORT |
-- 
2.39.5

