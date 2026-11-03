Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36074606A328
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 17:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=ii10myLK;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=AitugBnE
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8212B40265;
	Tue,  3 Nov 2026 18:07:22 +0100 (CET)
Received: from fhigh-a8-smtp.messagingengine.com
 (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
 by mails.dpdk.org (Postfix) with ESMTPS id 5D3C3400D6
 for <dev@dpdk.org>; Tue,  3 Nov 2026 18:07:21 +0100 (CET)
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 770CC14000B2
 for <dev@dpdk.org>; Tue,  3 Nov 2026 12:07:20 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-07.internal (MEProxy); Tue, 03 Nov 2026 12:07:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm3; t=1793725640; x=1793812040; bh=pVkeqLIh92XMz+3DS/n/p
 rfXHhnc0GRHtOJ/SEbLy7U=; b=ii10myLKvsIVR6al06K7R5fKxBZDLY3b4WWdx
 oOZAH2Lp7tHwZ0Ax0O3SlfE8Spo5cydrLY2ChyytxSobqsMbvXzr5DLU68IQiPRh
 KmKCP2RjREkpDgk9xLpwEwL5IDUSgIxlJcN7jDITAXBKUFHEi/FM9+h2lC+as+ld
 LQQ04p15gPCVEstNUVF8fqkTgkcgvJUWw/LsE2Z4sa16H/uzRnra/MWcwZYadzsj
 6SHcRbRzsD7jWJPmGjbQiW8kJ4RsJ6njGy9q9awvItpx4tePQLURmxx2etaIYGHp
 qje1yR0K9aQyDGw9vCsWGSdA7sdzU7HKpzbmkyGYA+p1ZTB4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:date:feedback-id:feedback-id:from:from:in-reply-to
 :message-id:mime-version:reply-to:subject:subject:to:to
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1793725640; x=1793812040; bh=pVkeqLIh92XMz+3DS/n/prfXHhnc0GRHtOJ
 /SEbLy7U=; b=AitugBnEz+PZ5mYQxQWlzU9P1+jcrTZAMTA9LS0wY1T0OwFJADm
 mcp1IRjK53ElA7Ric0EyPyz3h6o0mdnH+76kL6S311bJOsHq7eGyHfO8gKgnIiHY
 hNxIJxuoRb2u+msVTLdqVgmr7zWTaVjFVgBxwvhwUUts41FJyvD2cdCPHiUFiflZ
 0Sc4dZC9PxZ3f5HraiE7CK78WBrFzCauR8xkFY4DcDnhzdo0hFCHOtWzMHsqmr9d
 eaZ+Fe5te/Eqy5Nn2eCW48ae/M4R6i/qdUcSqTc/6feaQJtvFI/nXuKnt2GRVgmn
 RgBbKjwWPJdakIy7l3YeBCrEb+81UWzAi3A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
 repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793725640; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:TEvgxoZruk/7jOTh/Y9ooR8HlPEppy6dtn9r9Y610kyRXG2
 IGAaxEnhI5qgIbhWKVawhjTmnYIITvqm6lbJmfkZSsPbvtFl2vuYgmQtyJlFXLDb
 VmhbsMbx7356qpPTL6eUq9H1NVc1wkO1VzTwfkbAHoiJai1/1fSD3EiOtUQaBIR/
 NWhgxaJ20OeFwyfMl9WZ4f02oxybe9uCc2NXsY2+fVl3XyXbjZWha4Mu32J7an25
 It42Or94rhusDh9QcdqO/SJl0yFEsJmB+etLH4SM01SruVzkPwRhVW3A9IVDgyPW
 keHjpmqRVwk10Xm1H8f/8VxZFvvlZSqcHBXnBNA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
 repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
 action=mi-m=1; hc=8;
 hn=content-transfer-encoding,date,feedback-id,from,message-id,
 mime-version,subject,to;
Message-Instance: m=1;
 h=sha256:/EutjMJHAmM7PX09HREZMN6B/9onEmspZYR97RAqzvs=:Yi+GmtpT2x8rhpycL0yPS37EE63Wu88jMSyS1XiGjmI=;
X-ME-Sender: <xms:yBTqavlORP9wZg3Vc-ndhadZwUExDSBT7HLd8FwGtbLHh-n_L30C4g>
 <xme:yBTqaovnMj3X5VJF4w-ePHb_Fk275xmhRh1-FEYOvrmS0bL9fzbGHz09GmnI_fiLy
 a1frPUnGFiZBh8OqbuaF7jY8s1_uJr1SfTqsYffDSxJNbEgellOrQ>
X-ME-Received: <xmr:yBTqagtFiNFIWY7_7fnYa4_mqBohPLtmc3xw68XlkcYOaNoVvyiHOr1Oq5foZ1VQBUsOthWm3kgwZYmliOTfnHjvraa_>
X-ME-Proxy-Cause: dmFkZTEmquxfNF9a35ljCdtNje/T1r4zphZnHQBORE9RqsnzKgIh1HTj7A/T5zDmbAw1V/
 d8gneEX+NQU5cnDECO/QmQDbzH0Msw6QWGXpY4qZXHxsMYGV7NMoymbxZClKOZdPVej27k
 RUj+EQHi+E1NsWrhcLftSFbUzYcHI68dhLST5nmIqEyqEEUgEF2HFCJojPZhyQT1EK7cL5
 Mm8gQOUAr2GaSqwWj8O7cc/5HzJHs1+jeV33pQjeMNJX/QS8TRNRjhL0R6Axnfy3OQXLGh
 4H+S0KaD1BuJVKU41dDLIzxL25ixgd8vTysdoEfwQxGSg25fs+hwE9CzfVHYA5vLqQeDer
 knUg+j0H+qTKU8KS3+WjdrshAxodFEI7sY1+V0UW/YvvECVQgp3ZfkXP2S76JuM7RbVTlh
 Ez/IBPK1vrGaKx7POcylAaowv4wj8G4RdzEfUBEYw++TQn+oHY4rerD+rb3E+9Q9kVL9gy
 DC1XUHVd915YSenh2izw7hngVpf7gmrlMCLihGEqjO2H5fImXdj9wqCLA8ZG5GPrpmTPFz
 vvr2fvaPy2+rVPGxxB+1NaZhqtqBxijNXsOC3w812+IJp9qlbd2S5M+VTnsLNPf2aA/BVL
 mLF79FC8i2j7B+0LvVSfsHMqbg0l1ErS6jMsSvYWGTxTnodDBt+Mt9SwYi1Q
X-ME-Proxy: <xmx:yBTqakZc0XuXwG7zuZrwlVa6Nam_OVI9LK9xnEaK5T9Qcz5s-qOB9g>
 <xmx:yBTqahaZtRHCS0rtUYImc03c3XVcWHBCD8xJg1KaDjJOiKZFn5HodQ>
 <xmx:yBTqaoVzmU6HFlwpMMVNFU_MUWQEn5OooCkGwnd6zB0QtSDAL3a_HA>
 <xmx:yBTqag2j4MovYOr0TDUKzUCW18ortnVcCUTkUS9Pab-fBgMyRN3grw>
 <xmx:yBTqaqngY6HLRQIpI4kZQb4UsmxDPktCDVxUwnjJbS-To-VjrmREQ3KU>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for <dev@dpdk.org>; 
 Tue, 3 Nov 2026 12:07:19 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Subject: [PATCH] ipc: increase hotplug devargs limit
Date: Tue,  3 Nov 2026 18:07:01 +0100
Message-ID: <20261103170717.1243319-1-thomas@monjalon.net>
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

Derive the hotplug devargs buffer size from the IPC parameter capacity.
This increases the maximum devargs length in multi-process mode
from 127 to 247 bytes, excluding the terminating null byte.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 lib/eal/common/eal_common_dev.c | 2 +-
 lib/eal/common/hotplug_mp.h     | 8 +++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/lib/eal/common/eal_common_dev.c b/lib/eal/common/eal_common_dev.c
index f42a8d2349..febb584313 100644
--- a/lib/eal/common/eal_common_dev.c
+++ b/lib/eal/common/eal_common_dev.c
@@ -276,7 +276,7 @@ rte_dev_probe(const char *devargs)
 		goto skip_mp_req;
 
 	if (strlen(devargs) >= EAL_DEV_MP_DEV_ARGS_MAX_LEN) {
-		EAL_LOG(ERR, "devargs truncated (len %zu, max %d)",
+		EAL_LOG(ERR, "devargs truncated (len %zu, max %zu)",
 			strlen(devargs), EAL_DEV_MP_DEV_ARGS_MAX_LEN);
 		return -E2BIG;
 	}
diff --git a/lib/eal/common/hotplug_mp.h b/lib/eal/common/hotplug_mp.h
index 7221284286..bd2f0f296a 100644
--- a/lib/eal/common/hotplug_mp.h
+++ b/lib/eal/common/hotplug_mp.h
@@ -5,6 +5,7 @@
 #ifndef _HOTPLUG_MP_H_
 #define _HOTPLUG_MP_H_
 
+#include "rte_eal.h"
 #include "rte_dev.h"
 
 #define EAL_DEV_MP_ACTION_REQUEST      "eal_dev_mp_request"
@@ -12,7 +13,9 @@
 
 #define EAL_DEV_MP_DEV_NAME_MAX_LEN RTE_DEV_NAME_MAX_LEN
 #define EAL_DEV_MP_BUS_NAME_MAX_LEN 32
-#define EAL_DEV_MP_DEV_ARGS_MAX_LEN 128
+#define EAL_DEV_MP_DEV_ARGS_MAX_LEN (RTE_MP_MAX_PARAM_LEN \
+	- sizeof(enum eal_dev_req_type) - sizeof(int))
+	/* minus t and result from struct eal_dev_mp_req */
 
 enum eal_dev_req_type {
 	EAL_DEV_REQ_TYPE_ATTACH,
@@ -27,6 +30,9 @@ struct eal_dev_mp_req {
 	int result;
 };
 
+static_assert(sizeof(struct eal_dev_mp_req) <= RTE_MP_MAX_PARAM_LEN,
+	"Hotplug message struct exceeds IPC parameter capacity");
+
 /**
  * Register all mp action callbacks for hotplug.
  *
-- 
2.55.0

