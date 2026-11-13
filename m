Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833FA606B2C4
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Nov 2026 16:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x/sPa9/u
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8AEE4427E6;
	Fri, 13 Nov 2026 17:05:55 +0100 (CET)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com
 [209.85.210.50])
 by mails.dpdk.org (Postfix) with ESMTPS id CE306402A4
 for <dev@dpdk.org>; Fri, 13 Nov 2026 15:29:29 +0100 (CET)
Received: by mail-ot1-f50.google.com with SMTP id
 46e09a7af769-844a8bf7e25so1444019a34.1
 for <dev@dpdk.org>; Fri, 13 Nov 2026 06:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794580168; x=1795184968; darn=dpdk.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wWbFkv4PQetuvZjmZufeytvcLlHXZQPnPRgs0ePBy4w=;
 b=x/sPa9/u9e2kk2A7qBhKHGnCb0XmDlp+rTj6WwFE5CvndtEKaCjVcLtBu9j/qDSj5v
 Z09FIm/rmlDvByl65q0OnH2ZjmmL5eT4knvV6lJVhq7hVvbht1yrrw9xNYjbgF9wetLe
 ynfurrAOJbh0XW8eQof7/vukwyrICqm33FI21+oiPzAmCepDjQ3p6pQkmYZum7JAAsxq
 McupqaNdkHvpLvO5Zjwqga3cUxKiZQMhGkiSf7Usqbh5hWJoe4V/CsQaY6SqgRYUjeT5
 XbXaU7ajbVW2SltyUm0ctfAW68x0E0pXXZ2yNlkpp5WJRfbRFQTNhLcfITWqNClv8QU9
 HhrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794580168; x=1795184968;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wWbFkv4PQetuvZjmZufeytvcLlHXZQPnPRgs0ePBy4w=;
 b=BfHpN71tK16YnwLg3aouBKzol03mtGzY6y+CW1Q7g4+SJiLoFGUNW53Ql7rMApkqoe
 Xqbw5/t/+sFkwjCioy8M5YvUVN1n7p1XHSrJ8YfTMeanwUnViMK8zRDu/vN7WvAc3rjI
 QVpkOf7127lyD1HHc1nBwENuiOYx/gItNGkNSXRLRvf2Ou3sxBRZfExjj3Qn+Ksx4v5S
 rQYR3niRzBU6h3G1ZJLqM/PoIXHqlu2VwkOsgTI2IqftbkMMeNN4LMsr44B3wiOTTtFg
 Dc4nMGdws71UcERDQcUmx/ohkbX+avN2h9n8/EUcMoEMq/xsm/PtobmpplVUcHD6UAHN
 wprw==
X-Gm-Message-State: APuU4Z8wxu52dWuewCq8LnArbD5+yGjXdogNqzQ0VdEAmdXFpsQL2Vcb
 7LISWGrjFyUYahyq6xthUHXGBXFjL08PZ3NxsX/vCB64bOlY0QQLhoUb
X-Gm-Gg: AYBFou1233X5Kq1vr06LCOXodeRMV4aUrvF1Dxoy9lP0L8qhtwv62banj736f2U4UJg
 BR1n4vld+IH/wC49nzWdoQWnK9f9Gk3Ao15JumN3Chhv57LbA9baxn3GTwlS+x67EzmlLHS77JJ
 BsfVBk9b40QmoJdNiD3IX7xXacDjZ9F2cnEfccOwaLDg9lLwIcE16oLdFZeTJvGO+LQRFTq2+I9
 211vQ2GpBwpL6qDJufh5O0LPDyWagAxakVOiNavEJMxxax/rYXGkZDo+kW6r/lkDzUh3UbHTI1Y
 d2FiJM+yBJrgazKUoAhIgoC9UlIhFKE+xDp/QteOyo1pLXhgqTPhEgAXl+Ah9oJ+mIl4Vr+W2yr
 TgR5LZJZIDyCDO6GHYJp0hGPJr1gHd7nMecQoZm6VnR6Og93tAUr0jYOP4xytKj/WbtdOVN8OXY
 VeYXTcijDRD8l8wFShcPniOnlgMjeiqlCy247HrKvMUqtZrvdXW+eigFJFO2KZ0bJ2tPjMw0iB4
 vkOkstN+JWH4ijSC/WcNeETiHnPavZt2+BB1UbChaBtbQEfBPXLVBUxb+gKuFYjlWd0HnKYncO7
 ObXRx/9IMSKE96qgtyfh5zmpmoUUM+w8n0hhhrJ7dpip+9G1
X-Received: by 2002:a05:6808:13c4:b0:4cb:f21c:a795 with SMTP id
 5614622812f47-56e641cc0ffmr2037724b6e.29.1794580168318; 
 Fri, 13 Nov 2026 06:29:28 -0800 (PST)
Received: from localhost.localdomain ([85.172.76.155])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-56e70d6572csm2119003b6e.15.2026.11.13.06.29.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 06:29:27 -0800 (PST)
From: Bulatov Mark <ms.bulatov7@gmail.com>
To: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@corigine.com>,
 Chaoyong He <chaoyong.he@corigine.com>
Cc: dev@dpdk.org,
	stable@dpdk.org,
	Mark Bulatov <ms.bulatov7@gmail.com>
Subject: [PATCH] net/nfp: fix wrong argument order in nfp_encode_basic
Date: Fri, 13 Nov 2026 17:28:23 +0300
Message-Id: <20261113142823.5918-1-ms.bulatov7@gmail.com>
X-Mailer: git-send-email 2.39.5
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 13 Nov 2026 17:05:48 +0100
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

The function nfp_encode_basic_qdr() takes cpp_tgt as its second argument
and dest_island as its third. However, the implementation of this function
implies the opposite: dest_island should be the second argument, and
cpp_tgt the third.

Furthermore, the implementation compares the second argument against a
negative value, whereas the cpp_tgt parameter — as defined in the
nfp_target.h header file—consists of a set of values ​​that does not
include any negative numbers. The situation is exactly the reverse for
the nfp_decode_basic() function, which receives a value for which these
definitions are not entirely appropriate.

Fix this by swapping the arguments.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: e6858e7e7c ("net/nfp: move shared target logic to own file")
Cc: stable@dpdk.org

Signed-off-by: Mark Bulatov <ms.bulatov7@gmail.com>
---
 drivers/net/nfp/nfpcore/nfp_target.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/nfp/nfpcore/nfp_target.c b/drivers/net/nfp/nfpcore/nfp_target.c
index 0e7a5cbb05..239ffff869 100644
--- a/drivers/net/nfp/nfpcore/nfp_target.c
+++ b/drivers/net/nfp/nfpcore/nfp_target.c
@@ -728,7 +728,7 @@ nfp_encode_basic(uint64_t *addr,
 			 * address but we can verify if the existing contents
 			 * will point to a valid island.
 			 */
-			return nfp_encode_basic_qdr(*addr, cpp_tgt, dest_island,
+			return nfp_encode_basic_qdr(*addr, dest_island, cpp_tgt,
 					mode, addr40, isld1, isld0);
 		}
 
@@ -741,7 +741,7 @@ nfp_encode_basic(uint64_t *addr,
 		return 0;
 	case 1:
 		if (cpp_tgt == NFP_CPP_TARGET_QDR && addr40 == 0) {
-			return nfp_encode_basic_qdr(*addr, cpp_tgt, dest_island,
+			return nfp_encode_basic_qdr(*addr, dest_island, cpp_tgt,
 					mode, addr40, isld1, isld0);
 		}
 
@@ -763,7 +763,7 @@ nfp_encode_basic(uint64_t *addr,
 		if (cpp_tgt == NFP_CPP_TARGET_QDR && addr40 == 0) {
 			/* iid<0> = addr<30> = channel<0> */
 			/* channel<1> = addr<31> = Index */
-			return nfp_encode_basic_qdr(*addr, cpp_tgt, dest_island,
+			return nfp_encode_basic_qdr(*addr, dest_island, cpp_tgt,
 					mode, addr40, isld1, isld0);
 		}
 
@@ -786,7 +786,7 @@ nfp_encode_basic(uint64_t *addr,
 			 * iid<1> = addr<30> = channel<0>
 			 * channel<1> = addr<31> = Index
 			 */
-			return nfp_encode_basic_qdr(*addr, cpp_tgt, dest_island,
+			return nfp_encode_basic_qdr(*addr, dest_island, cpp_tgt,
 					mode, addr40, isld1, isld0);
 		}
 
-- 
2.39.5

