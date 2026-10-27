Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2142E606A31A
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 00:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=l93DxpFb
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C06C8402E5;
	Tue, 27 Oct 2026 01:14:53 +0100 (CET)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com
 [209.85.219.49])
 by mails.dpdk.org (Postfix) with ESMTPS id 130E0402E0
 for <dev@dpdk.org>; Tue, 27 Oct 2026 01:14:52 +0100 (CET)
Received: by mail-qv1-f49.google.com with SMTP id
 6a1803df08f44-91b9e758c50so6405646d6.1
 for <dev@dpdk.org>; Mon, 26 Oct 2026 17:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793060091; x=1793664891; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5bGa/Fa+3u8Cyn2+veSZ4YhVkLmKZq+lU5tX5fXoIZI=;
 b=l93DxpFb81rYY+2F+7HQnCvZzRCCWuqifCSTPV24HxaKfmhHboVIJzX8DQKjGvlfbC
 gThpkANlnx/lQVYdJ9zv+7zSZfb1DCWoiNwzmht1/P32bejCDY3OBmWqBFQHTSfTvOUA
 Ds3697pxqinIk2ai7oRQjzbsHlOPWP5XwsfK/MCvPI4zxvqFd50m6MdSgTUKFo8aMVat
 clailiOqozNPQkf/57DG6ns3kxpzydJ278fexxzA4wiihbC/CdrMcb+yhUnykM8yMoUb
 uNMDjO9YlZA3aO90mi1R3PhWPdHKfX4zvHhZmPW7Dz7lI1iAxmMIvGH2X6k5EdQTemNz
 nMyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793060091; x=1793664891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5bGa/Fa+3u8Cyn2+veSZ4YhVkLmKZq+lU5tX5fXoIZI=;
 b=Y+Ii4h/w8G6mN5VCdJ8R3OLMv6r2hbRUSrsgmevbo0urBYOV7j4honW1ZPkaidWheW
 WcQz6WGpd541NKc9XzqgQkN17zljFESH2BuDZGUVOng1GfLqW5fKsDVzF4nREf5w93fi
 Fo6WUOqNWKCu7iRYxqMx+a2n4iLRHeE2NcA0hJXXfFttp9g5imWX+oXhQ1pxv8SXzf5/
 tzxe8gR+YpJeEb9lT4qq7kpf/1BkG5GijT9LKj/tweAdcgH10354QEb6LYY+VCsq39ir
 ML/ceJ6sK9//vWUS0Gwu70RBA/JkbgdTrfB5ASWkbYwn5cwAR1PfjQLKY1FvZ+6LjlQc
 bXzA==
X-Gm-Message-State: AFq9FYIcMIYvZzdaB/KqIpGAOzu73mDbKmZaZoMHkgfAgENSNYh7oo7m
 HRyO4ojutsyePRqc2MfvFGnjlwaZWTrCSnAkllRkwTPfJZobN5PDSpELT7MFtg==
X-Gm-Gg: AYBFou1fmSx680eDNYkzYfym6rjFdP/c9ygcQU14//b4vr8045HQ9wA8IXWkrPhsgWt
 DQ2Mvs7FEE1DmgDzdKZoAb/dmDEsRKOnA0d4s81FGGRT8CTXPJoQ8OdiMNwHRADgKwV7tWdGuai
 a9UNnXk2PwaO8WKpNbbGuf5hq/GphQ0i4IUqdfAst2ZpO17UoQtK4zRQjyuMVXYa4SwRZ9Hy9Qu
 BiyJdMjyWvPF869LL9tFI8kWqteX+QkfZb60LumzHA6Ddnx/b+DgbxOfTD2RN7YGvA0dLMOJLUW
 gNXnl5Sguw3bZILIi785kmICV1Qux5EBt6uDVHtAA45qK60Mna4Ok1r3kZ+J+zrGioKwAwkI3Tz
 Iqf655HOlHZZ1+FAapI71Mw/2UzLDVvoEbEqlYRPfXE/XeAzJFjoSUvT994AvWqScn70wx/RJEw
 FuCUkapohHXti7M1RPBV0FqmQgKGhpBRMTFbhcZxGSYbNRemKzpyvsfUvtNt0hzyJ+H1m0cC3Lj
 sg0L5CgPVjIw1rEQUKwcguneIF8588DzzJMEfGt5RpWbYsLGdMLE/agTYM7ASyddQi3uVsMzD+X
 fRL0KxR35tngfzs1dFJifsbHsQSQylYQcgWqq3GL9Wn1+A7p8ANUmkWAvRwO+Zce4N5GthYHHrS
 InhwSqx6gRRmhXLSzsvlDYlmCKds=
X-Received: by 2002:a05:6214:3d86:b0:91c:35c1:1197 with SMTP id
 6a1803df08f44-91c6d2bdec9mr24608646d6.16.1793060090799; 
 Mon, 26 Oct 2026 17:14:50 -0700 (PDT)
Received: from bos-lhvwah.bos01.corp.akamai.com
 (g2001-4878-8037-0700-526b-8dff-fef6-cfbf.deploy.static.akamaitechnologies.com.
 [2001:4878:8037:700:526b:8dff:fef6:cfbf])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c65ef7b0fsm31449136d6.19.2026.10.26.17.14.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 17:14:49 -0700 (PDT)
From: Robert Sanford <rsanford2@gmail.com>
To: dev@dpdk.org
Cc: vladimir.medvedkin@intel.com, Robert Sanford <rsanford@akamai.com>,
 stable@dpdk.org
Subject: [PATCH v1 1/4] fib: fix full table overwrite on address wraparound
Date: Mon, 26 Oct 2026 20:14:20 -0400
Message-Id: <20261027001423.3028072-2-rsanford2@gmail.com>
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

When a prefix whose range ends at 255.255.255.255 is added, deleted,
or has its next hop changed, modify_fib() walks the more-specific
routes under it and installs the next hop into the gaps. If the last
of those routes starts exactly at the current left edge and ends at
255.255.255.255, the equal-edges branch advances ledge past it, and
ledge wraps to 0. That branch has no wraparound check, so the loop
continues. With no more routes, the final branch computes redge,
which also wraps to 0. Its ledge != 0 exception, which exists for a
default route added as the first route, lets the call through, and
install_to_fib(dp, 0, 0, nh) overwrites the entire table. The call
returns 0, so the corruption is silent.

For example, with 0.0.0.0/0, 0.0.0.0/1 and 128.0.0.0/1 installed,
deleting 0.0.0.0/0 makes every lookup miss. With 10.0.0.0/8,
255.255.255.0/25 and 255.255.255.128/25 installed, adding
255.255.255.0/24 makes every address, including 10.1.1.1, return the
/24's next hop.

Commit ab1b927cd73e ("fib: fix adding default route overwriting
entire table") added the wraparound check to the other branch only.
Add the same check to the equal-edges branch.

Fixes: 880bc2b5f3bd ("fib: fix adding default route")
Cc: stable@dpdk.org

Signed-off-by: Robert Sanford <rsanford@akamai.com>
---
 lib/fib/dir24_8.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/fib/dir24_8.c b/lib/fib/dir24_8.c
index c135285a65..68029c6165 100644
--- a/lib/fib/dir24_8.c
+++ b/lib/fib/dir24_8.c
@@ -436,6 +436,12 @@ modify_fib(struct dir24_8_tbl *dp, struct rte_rib *rib, uint32_t ip,
 			if (ledge == redge) {
 				ledge = redge +
 					(uint32_t)(1ULL << (32 - tmp_depth));
+				/*
+				 * we got to the end of address space
+				 * and wrapped around
+				 */
+				if (ledge == 0)
+					break;
 				continue;
 			}
 			ret = install_to_fib(dp, ledge, redge,
-- 
2.34.1

