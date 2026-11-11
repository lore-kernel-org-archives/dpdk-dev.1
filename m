Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D568A606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 08:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PWfFc+He
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5600141144;
	Thu, 12 Nov 2026 09:07:41 +0100 (CET)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179])
 by mails.dpdk.org (Postfix) with ESMTPS id 024E74026A
 for <dev@dpdk.org>; Wed, 11 Nov 2026 17:55:58 +0100 (CET)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-36eb1cb7aabso5141627eec.0
 for <dev@dpdk.org>; Wed, 11 Nov 2026 08:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794416157; x=1795020957; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=eBLp+8cjan7LEm4N8O6feWd/T49cR1Tn39rUshhZJoY=;
 b=PWfFc+HengvDyIf6ajz7+HDsvQN8VtmNvRkIUiWEBqypcwggX/CrvHHAvsd9Bo6aCs
 yUDeD/WbLhLOt3XnuUhhk9VsxnY3Wqka+P7/tsy4jUOFFCfvuTxYWpWqyiRvrpwb5BRV
 UsYm1Dyg1S20YCuqpQOWD0LCf51PdZ9GvylpiBUg8TfNsetI1WD6KY3jkpPtyytvxLGX
 JN8K3rwu0ncnN+FFGsZgCa24lsyF4FrODvIPsUXmqiqthz9qPQ0xnSqKsPM1RiXMiweV
 qinA3Gc8NXlRqm6OuKThTYzSXGYwGTu2YqaVg0nP54oKxr3j3yfCrRR7d5ssdbeV2LDr
 g5TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794416157; x=1795020957;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eBLp+8cjan7LEm4N8O6feWd/T49cR1Tn39rUshhZJoY=;
 b=n27wbJU8HmEYAt+2LhWJhlCn69JUduXnytT1nJlGYG/I5c/BiMBQWvgqeNMO25rR4k
 Esij/iLeeRxiL584ZTc3uRcp3np3Xmd9Lu9g+QrmpEEzztgrYVBQ4jVpRF3CA6Im355g
 fo62qYh2dtezuSYyK8k0PTG5MfzyKaoM/qK5wN9hdrP6pmI9SgkF6z/Qff0mISuZiS5J
 EVKmvOUZfp6Aj/XdWIZtmkUQt/PB+EV4z5Q6sl3JzaTEFAUtmvrtWD9hHecnan0NGRs8
 kzLS+C2nC1NF1ilXrhbnrCbfsf/BywPC0VTP6XOarc794NbpB/ON1/+DELltccvL5oSg
 nqaw==
X-Gm-Message-State: APuU4Z/z1Ev20RH8m21wwncwX9Uq4faOzY/w2EyaqGfhrbR1qJuo4kHK
 KlOlekUOsm4ME0fa4dz9WUxziaIguzMfGzdU14yDZOyoAtUPjKl5y9oT
X-Gm-Gg: AYBFou2qa49LSys63TT8hE2tzmWAl+FutM9BMG5FCDviOUWSbrHXsE1zaiHav5WtrMW
 iwWyIKZ/agQUEGGbQ1MgyFHSCymJ4ppZS8Wir8/JsPpu7awmEfv9h617CFHWEv3OUTkmH4K1WL1
 tZ3LEXjgyU89QS1V8ILddI0DLp7rIIQHpkWAhRN9WfLZa2muLRo0qybtu2ZlZOwnqD4LbjOVIH7
 kX8yGrn6rbrouSDB3VEpe+kusYKAPW9MEVQS9hJvUAf56uJwXWZ4jz1WJVsRH/SFveD8/cNLGih
 oVB8qb891kZLA4qKmPtRkauJLvLF29Ac3S5SU6v+PFQaKFetdMgsbJGGuFt/amTPrNUgh5bTSmW
 bHMGz69se5+PWM/tIM6uQfd5/MQSVnPH+E5O4KBVsVri0GpmeeAsOZBy8HcodB9e+q5u3QMMwOX
 FKrKfkO/3k1jZZ6GnySEHIQY2Jle+Eqy6tfcWni4ynC4GaPytEexiQdaMC7KN53k0dGDWXOlaGy
 FAhGp21SPI9yB3+FBCQhzKV+tBCovMlhUpSlQNKQj0AbN6tmNTgrCkp+yBEic2a8ktt8mpOU5gW
 g490NngYOvSdL0wUgtYRhs+3TwORAZuKyAiPkCLxrQLGj+3a/ue7ePokNjjEeR0gzr5Q+Q==
X-Received: by 2002:a05:693c:87d4:20b0:36c:3b8a:8090 with SMTP id
 5a478bee46e88-37683188868mr3329500eec.2.1794416157052; 
 Wed, 11 Nov 2026 08:55:57 -0800 (PST)
Received: from localhost.localdomain ([85.172.76.155])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3766146551asm9633954eec.1.2026.11.11.08.55.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 08:55:56 -0800 (PST)
From: Bulatov Mark <ms.bulatov7@gmail.com>
To: Thomas Monjalon <thomas@monjalon.net>, Long Wu <long.wu@corigine.com>,
 Chaoyong He <chaoyong.he@corigine.com>,
 Peng Zhang <peng.zhang@corigine.com>
Cc: dev@dpdk.org, stable@dpdk.org, Bulatov Mark <ms.bulatov7@gmail.com>,
 Alexey Simakov <bigalex934@gmail.com>
Subject: [PATCH] net/nfp: fix bad copy paste in nfp_net_flow_merge_ipv6
Date: Wed, 11 Nov 2026 19:55:15 +0300
Message-Id: <20261111165515.6157-1-ms.bulatov7@gmail.com>
X-Mailer: git-send-email 2.39.5
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 12 Nov 2026 09:07:37 +0100
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

The nfp_net_flow_merge_ipv6() function contains two blocks: the first
iterates over ipv6->src_ipv6_mask, and the second over ipv6->src_ipv6.
However, in the first block, ipv6->src_ipv6 is passed as an argument
to sizeof() instead of ipv6->src_ipv6_mask.

Fixing this by replacing ipv6->src_ipv6 with ipv6->src_ipv6_mask.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 9f27cb8892 ("net/nfp: support IPv6 flow item")
Cc: stable@dpdk.org

Signed-off-by: Alexey Simakov <bigalex934@gmail.com>
Signed-off-by: Mark Bulatov <ms.bulatov7@gmail.com>
---
 .mailmap                       | 1 +
 drivers/net/nfp/nfp_net_flow.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 9db000bb6b..6177ca8b1e 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1057,6 +1057,7 @@ Mariusz Drost <mariuszx.drost@intel.com>
 Mark Asselstine <mark.asselstine@windriver.com>
 Mark Blasko <blasko@google.com>
 Mark Bloch <mbloch@nvidia.com> <markb@mellanox.com>
+Mark Bulatov <ms.bulatov7@gmail.com>
 Mark Gillott <mgillott@vyatta.att-mail.com>
 Mark Kavanagh <mark.b.kavanagh@intel.com>
 Mark Smith <marsmith@akamai.com>
diff --git a/drivers/net/nfp/nfp_net_flow.c b/drivers/net/nfp/nfp_net_flow.c
index 0e5003ebe3..80b4db1f4f 100644
--- a/drivers/net/nfp/nfp_net_flow.c
+++ b/drivers/net/nfp/nfp_net_flow.c
@@ -296,7 +296,7 @@ nfp_net_flow_merge_ipv6(struct rte_flow *nfp_flow,
 	ipv6 = (struct nfp_net_cmsg_match_v6 *)nfp_flow->payload.match_data;
 
 	ipv6->l4_protocol_mask = mask->hdr.proto;
-	for (i = 0; i < sizeof(ipv6->src_ipv6); i += 4) {
+	for (i = 0; i < sizeof(ipv6->src_ipv6_mask); i += 4) {
 		ipv6->src_ipv6_mask[i] = mask->hdr.src_addr.a[i + 3];
 		ipv6->src_ipv6_mask[i + 1] = mask->hdr.src_addr.a[i + 2];
 		ipv6->src_ipv6_mask[i + 2] = mask->hdr.src_addr.a[i + 1];
-- 
2.39.5

