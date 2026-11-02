Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09A9609CD89
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 15:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm2 header.b=fNfJ6b79;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=kUxBmjpH
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5422C40E1F;
	Mon,  2 Nov 2026 16:28:15 +0100 (CET)
Received: from fout-b8-smtp.messagingengine.com
 (fout-b8-smtp.messagingengine.com [202.12.124.151])
 by mails.dpdk.org (Postfix) with ESMTPS id E830040274
 for <dev@dpdk.org>; Mon,  2 Nov 2026 16:28:13 +0100 (CET)
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
 by mailfout.stl.internal (Postfix) with ESMTP id DCF471D000EE
 for <dev@dpdk.org>; Mon,  2 Nov 2026 10:28:12 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-08.internal (MEProxy); Mon, 02 Nov 2026 10:28:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm2; t=1793633292; x=1793719692; bh=nt2saFUlHw76/BZv9VImJ
 Kwyh3eEMtOIKWBrqg0nzkU=; b=fNfJ6b79lvvxkbzBilusjp0+IDkKp+0Uqrztu
 7Ar1RetTwZKM0UqMH9Jhusze7JIaxGBekCDy9C9eWJoqFpugj8mkE2bUP+uvAWN/
 ZlQkJII4iy2d8OHSraXLlXpK2eQPQWz9nwFWAoPa34mvaVHcyfMmRi+xBcTwXGyJ
 aH9guhOk+ryD1oCQxb3/z/YpgynkP5w9pQ2bBHaOOtUDDon1y1LmLeck115q6t60
 e23slOQbqq1fOnWmVCyRqI2O04ynpDHV3v/2KbucH52hBkpfLjplyu+V9spgZZ9I
 P9bAghLjb+G9nseRWR96EhjAGiii4SAeqE1oqkXxJ7jKyVLbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1793633292; x=1793719692; bh=nt2saFUlHw76/BZv9VImJKwyh3eEMtOIKWB
 rqg0nzkU=; b=kUxBmjpHjgg9WjeJ9R7ZXFinClik3enrZcKh509isbSlsy6AlKh
 a1E1rHeDnqyJFJrqSyC1E+HeeShZGusFgne/RgukspPDOkCv2VKXQkNcKuQHbTTp
 WrTAvBXsg+UXcEJ/ud813YlMO2znS1mcZD6S4hsEmiVpm2TRQFrQKPPe2WRBWKuF
 DzNvec+ftzY+Og8ZeNDS02S5YGaSqVKqE4y91aLtbaFrtXU1oEOikJeWYFHwuq2V
 iBnBTStz+0+b5drBR+aV8axhgL8zy+hc/3yMZwSM3sI51NJ0JotRlUX7Ex11Tk/x
 GRXyTdgqrTjg4ezKsLiwT1liLSrtfaTX6dQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
 repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793633292; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:iZB+VVFOUFvmoRQEwbL01OhAGPetwdfqa+XLTsQa9UziyMe
 K5BnGtj9TnH6BfwxyB/QPXhPRqQnvDxFAqC3pTRcQbBJs030dWivIvMHZWUwFYad
 wIMVs1vwU87+XVaP1Ce31W14N4JeYnJOxhDa7PM+0bxyj7ufq0Aj6ieAr6pf3kIh
 3+2iCbesvFSd3j0RwqFFJ9q3X/t+zffE8LhCKmsorxtDNjm/AiWuslm3EdOLIJsp
 7R3aeC1zI6GpeFJ1Fh9h94qTR7rSMMhmaSMH1wsknEy5t08JGNnTauu7QalRhy0w
 1KFgKMVg07NbjWWz752iZUl47fu2J6KSgMgoNww==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
 repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
 action=mi-m=1; hc=9;
 hn=cc,content-transfer-encoding,date,feedback-id,from,
 message-id,mime-version,subject,to;
Message-Instance: m=1;
 h=sha256:9v1lPuecBdjF0zN4hh+yTe+DFQAzD043weuBCeR01TU=:3HzOS+MuJFQ+t94M3IO4eT8BtacfZtxOprMBptEuAfQ=;
X-ME-Sender: <xms:DKzoauYeAy4UhKtL0C2GaGA8-wI9VXd0lDOGxJ_PyWShcC3pZMexjQ>
 <xme:DKzoamrVHWR6bvqnON9UGUKfTkFSPZ86VZ5MkWJ-vzqL3-Lwh9l-VqpCW_PCKglOi
 YPXInbogxSDAaGSVg5cof2bYhbCpNnrnAcxggJOAF9XKOKesyxr_2Q>
X-ME-Received: <xmr:DKzoaqq5vPDt38jIbK-P2LszRji5chhAegMNmyyHodE-IS7cQm1fyDqFem4Rb4H4IZ8j>
X-ME-Proxy-Cause: dmFkZTG0pexkiO8SLywR9SGwcSWyxKoFnHrbg2hw2qS4LDz9HRZRMrFiiXQplu9ypb3TZG
 +dML15Na8pAz2FnYFyq5+cZnUGn9GkokT9afHreELQoaj0vkHkg77L82K5eDWWznouIROF
 3MYudgYN+fGpr1Ub8dMpvmOuKPHuJVLnYo6jUoKsC9M0n7+1l2SpglL6zvyIyhKEUHQMV/
 pGdu4YH82hD/wq8coY9x+D0fE9moDfsIxX00aQc7fOyuUswBJGAiOebWW8jq3gupsPm6Ds
 fkPPB7qnlh9rIES0dJx3VP9qnez8nhcTrfsQW2OfXOm5/jQbvjBb4cxa7T3+b3S9YlnqQC
 /aA3ZfPJAmyivStWcc73mMNxPdaPsatk1eFLFSdXcjKEgPrUA4Zy1K/qzx3rlR+OiDZTrQ
 kVazFbSqIIECPLvgzbiolZgXCPyKPe7BRXoZn7WZMFfnXblf+LBzZrC48pPHigX2s0eGcD
 RWj0jy/PiqiI37XdlIF03gvufiEm1UFVjhHyLH+Nk9LhjLPNMu8qWLFMuCn5ju1NG9fs+F
 Sa1xHN2oH+GkyEUG7OIzv9XYqK00T+qWbLj3UmT13fBl6jPqkaKsGyinVNw9qPnd4zas2/
 +QQgZ6P3XKFI1ROndPSVZwCqB0YJDPEV3HEpQA/aeIx65avyPKwPZV686epg
X-ME-Proxy: <xmx:DKzoao2_KtjsqfUQiSS3aqYT0sCaxwUz145r3BcxIqGEZGwQ681WgA>
 <xmx:DKzoahCGInamEyv2XZc1dt-nMjmNhAfPTJLwQGCyf_fOQHQ8cNYIDA>
 <xmx:DKzoaofyq7GwstMNhlsXKMhiUgsZoJsBdK9lebY8vTxjnIeMY-V5Aw>
 <xmx:DKzoauh4J2auXmyqELBFi8L9RV0bVqMMR5t8d1iGkmVeMOD_u5i6YQ>
 <xmx:DKzoaiY5uBdQAxO4W3gm5pWQn4XlltByHfSz0HC9RzID5-3rjFlwHm45>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 10:28:11 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH] vfio: fix cdev build with old Linux headers
Date: Mon,  2 Nov 2026 16:27:59 +0100
Message-ID: <20261102152805.644416-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.55.0
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

System headers may indirectly include linux/stddef.h
before the imported UAPI headers.
Both versions share the _LINUX_STDDEF_H include guard,
so the imported header is then skipped.

If the system header lacks __counted_by,
its fallback definition in the imported header is not processed,
causing a compilation failure in vfio.h:

In file included from lib/eal/linux/eal_vfio_cdev.c:14:
kernel/linux/uapi/linux/vfio.h:1524:51: error:
expected ':', ',', ';', '}' or '__attribute__' before '__counted_by'

Include the imported UAPI headers before the system headers
so their compatibility definitions are available.

Fixes: d129414711aa ("vfio: introduce cdev mode")

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 lib/eal/linux/eal_vfio_cdev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/eal/linux/eal_vfio_cdev.c b/lib/eal/linux/eal_vfio_cdev.c
index 4a955248ae..e7cd547c1c 100644
--- a/lib/eal/linux/eal_vfio_cdev.c
+++ b/lib/eal/linux/eal_vfio_cdev.c
@@ -2,6 +2,9 @@
  * Copyright(c) 2010-2025 Intel Corporation
  */
 
+#include <uapi/linux/iommufd.h>
+#include <uapi/linux/vfio.h>
+
 #include <dirent.h>
 #include <fcntl.h>
 #include <limits.h>
@@ -10,9 +13,6 @@
 #include <sys/ioctl.h>
 #include <unistd.h>
 
-#include <uapi/linux/iommufd.h>
-#include <uapi/linux/vfio.h>
-
 #include <rte_log.h>
 #include <rte_errno.h>
 #include <rte_memory.h>
-- 
2.55.0

