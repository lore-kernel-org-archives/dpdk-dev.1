Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB8D606A321
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 00:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MUTGk/xT
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F25C340663;
	Tue, 27 Oct 2026 01:14:55 +0100 (CET)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com
 [209.85.219.41])
 by mails.dpdk.org (Postfix) with ESMTPS id AC8A74060C
 for <dev@dpdk.org>; Tue, 27 Oct 2026 01:14:53 +0100 (CET)
Received: by mail-qv1-f41.google.com with SMTP id
 6a1803df08f44-917b78dfe30so52437546d6.0
 for <dev@dpdk.org>; Mon, 26 Oct 2026 17:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793060093; x=1793664893; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Abcn7FZhQZPKNeYCIukqnHny3oQsp5mjtEL8xaX6AOw=;
 b=MUTGk/xTX8Gp8Ikgaz1iUXXld3ecIQ7HCTopcqUYVywRsP0MNXoyAwyEvN6RwB3PNL
 fNHI+0tcmWPYhWM1BWK3neHp3QhlsJK9ADQVCz9INdYjZunWKKRBLOOLFedpCl8UmP0g
 R0qwOItWi83Bq3BAiOO7FwH8ZpPUeOo6iozDN0esTXPRsmJyxpXcXx1pU7bRcEzhUFQv
 Zh3HbOrr3s2KnWErptjwoFRzsMYp/5nQX98/5n5SWMpimwZ4oORw2jxKEUWiII/lSi6n
 WmPlCEtGToAwyLpeFkhQGqlRmTSlsqbuWAYGXO2ZMuxyPhHEf26hqnBholUkUfpq3J8a
 zwiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793060093; x=1793664893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Abcn7FZhQZPKNeYCIukqnHny3oQsp5mjtEL8xaX6AOw=;
 b=pNPdYKCegzrhowD6T/DEQASuE7e+J71AYp57F67DsfycPPo2QyhjaLO0b3EJVNL1ho
 tM3dVJQDl4CJe3uCjTNJLKSL5nClmL1FWggKKn26E+JHdA2ozDr0MmusBLEd3TDGzCid
 pGcSKW4qo41C3YELeeD0sCoMZwjlGXqrv8dcFU8g7hm0vEiTDrpTLEoIUh7t57NBbFTV
 CdEQFadLr7HUSS9NmQwOvifgUUz0OpsqnFANFJDTu77Q6Vw99P2SR+TA9FPLfb2lj3No
 dze3SlzoWM3gubLPyyjkhjfj7xUT6FI4AM92qYNi34ElmU0A+wgBrE4jRfG9Y1h734x8
 i+4w==
X-Gm-Message-State: AFq9FYKDvgTipxBDAvw1OxeAjV3NyIWN5PgtoV7qs1iTN6J5rjsEd2PX
 sjxEThei+XiOKK2FWlQd+/tIwH78fWvLT/oXgblsitsxGK5bZ+NIQ6tWVAm2+g==
X-Gm-Gg: AYBFou0PgyGjoeYXFKvs1/mwjQtQyA1urDOhGUCJ3i0GV7V9K0xv6Jcdja8dXPQdNwu
 YV52RbUtYo0xgm/DtVyvXvI5fdvzottMVzc7SvBwpxF496Fgj0zLQamr5jshBg0xAMY4PLHbk67
 +rz7JdpVa2Hjw4AQ1Qp6seMPRG0FjyTVIyTOS5VCW2PnPdU4Tuw3qKT7PalH1dwNJsdg3vTu0V+
 CLjzDUAlVsiqUw9siHGl2LMCPWe/fkTDg5emqYf2eWzD0oFiL1eFSoj90In8kFR8bdKvMWnrZ3f
 scrlwP/geuZnqsggsO+qiLIhJQLRgtYQK8EMGMb7YNYI4jLtwA/YXOEJ0YuQx3tI6KJBXQ+eB0z
 SAELpy8L/28wsaRfY2rGvKO+f1ILdQ7Dnv6A9+h+yG8VihKZhYlzyGOefp/o5pDla7uT5sXIUVd
 gA7Y+rLBxvGqF/V2hQKIQC1whpCKvEqHd1dgXciRfF4VJbQyOdM9Jwf4eWdyXqMKojvuaOJiaXu
 mKfXfOmsvETl6GvzjJFmjQLCI996pYASkiQB1UD0EiV0iXYbs62DCYjK5uPPZWuBGOHKPlGpE+j
 umi6APz5eB2XqAOaHDOJN+LsxD/O42kID1sMFVzRzWRQYu9DGZNglVMwKq/c30KoIp91RbVF5yz
 5kMHG2R0wArvFYrzwCWigY3gAtlk=
X-Received: by 2002:a05:620a:460f:b0:93e:53fd:4139 with SMTP id
 af79cd13be357-940ef7aaeaemr1192788685a.9.1793060092423; 
 Mon, 26 Oct 2026 17:14:52 -0700 (PDT)
Received: from bos-lhvwah.bos01.corp.akamai.com
 (g2001-4878-8037-0700-526b-8dff-fef6-cfbf.deploy.static.akamaitechnologies.com.
 [2001:4878:8037:700:526b:8dff:fef6:cfbf])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c65ef7b0fsm31449136d6.19.2026.10.26.17.14.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 17:14:51 -0700 (PDT)
From: Robert Sanford <rsanford2@gmail.com>
To: dev@dpdk.org
Cc: vladimir.medvedkin@intel.com, Robert Sanford <rsanford@akamai.com>,
 stable@dpdk.org
Subject: [PATCH v1 2/4] fib6: fix full table overwrite on address wraparound
Date: Mon, 26 Oct 2026 20:14:21 -0400
Message-Id: <20261027001423.3028072-3-rsanford2@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027001423.3028072-1-rsanford2@gmail.com>
References: <20261027001423.3028072-1-rsanford2@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Robert Sanford <rsanford@akamai.com>

When a prefix whose range ends at the top of the address space
(ffff:ffff:...:ffff) is added, deleted, or has its next hop changed,
modify_dp() walks the more-specific routes under it and installs the
next hop into the gaps. If the last of those routes starts exactly at
the current left edge and ends at the top of the address space, the
equal-edges branch advances ledge past it with get_nxt_net(), and
ledge wraps to ::. That branch has no wraparound check, so the loop
continues. With no more routes, the final branch computes redge,
which also wraps to ::. Its exception for an unspecified ledge, which
exists for a default route added as the first route, lets the call
through, and install_to_dp() with both edges at :: overwrites the
entire table. The call returns 0, so the corruption is silent.

For example, with ::/0, ::/1 and 8000::/1 installed, deleting ::/0
makes every lookup miss. With 2001:db8::/32 and two /121 routes at
ffff:...:ff00 and ffff:...:ff80 installed, adding their covering /120
makes every address, including 2001:db8::1, return the /120's next
hop.

The same commit added a wraparound check to the other branch only.
Add the same check to the equal-edges branch.

Fixes: fd66617c5774 ("fib6: fix adding default route as first route")
Cc: stable@dpdk.org

Signed-off-by: Robert Sanford <rsanford@akamai.com>
---
 lib/fib/trie.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/fib/trie.c b/lib/fib/trie.c
index 187360d1c8..59f043ce0e 100644
--- a/lib/fib/trie.c
+++ b/lib/fib/trie.c
@@ -506,6 +506,12 @@ modify_dp(struct rte_trie_tbl *dp, struct rte_rib6 *rib,
 			rte_rib6_get_ip(tmp, &redge);
 			if (rte_ipv6_addr_eq(&ledge, &redge)) {
 				get_nxt_net(&ledge, tmp_depth);
+				/*
+				 * we got to the end of address space
+				 * and wrapped around
+				 */
+				if (rte_ipv6_addr_is_unspec(&ledge))
+					break;
 				continue;
 			}
 			ret = install_to_dp(dp, &ledge, &redge, next_hop);
-- 
2.34.1

