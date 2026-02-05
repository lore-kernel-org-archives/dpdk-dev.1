Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FB8ECD9AA
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 21:31:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA4BB4064F;
	Thu,  5 Feb 2026 22:31:06 +0100 (CET)
Received: from fhigh-a4-smtp.messagingengine.com
 (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
 by mails.dpdk.org (Postfix) with ESMTP id 8144A4065D;
 Thu,  5 Feb 2026 22:31:05 +0100 (CET)
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 1C2F01400088;
 Thu,  5 Feb 2026 16:31:05 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-07.internal (MEProxy); Thu, 05 Feb 2026 16:31:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1770327065; x=
 1770413465; bh=DM3EllO6W0yWS3TJUdT19etRo+s3o59BWIxFqmIkyHA=; b=l
 DCr/KNlbwVAbUD9FvB2cWCLPw6KiywXB2SLTBPPRbhToETE8DuTYHlsW2zP+CVmR
 im5dYFaFNBxM/1n+X5M9AbJk4ywho3SpLsj/jZHATxrd8iyS7GE/QGrAjmbRqZ47
 IwfJS4suFSLDvRST73BtuPcxocmX7HWIYg4fYyJXV0H8ZbY6LqikSrfJWNAtDL2J
 Jp5lqT4ubk+NaeHF2JlGWMVbcCpubMe9EnDvy1v//3xLQTXtxGS/3Psq84gvNxVO
 DXrfQYXdeframhq8DTYo6k50eF6o+c4ylzLZlGBB7+5ZHRKLmf1ndIsFNWbXYQAw
 5s2mDCHsVfojz3WDVza9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1770327065; x=1770413465; bh=D
 M3EllO6W0yWS3TJUdT19etRo+s3o59BWIxFqmIkyHA=; b=j1bE/7SessNudifbm
 hCu5FFnbGKDhI0fjwtFcnffuIzhf2Pg2FWNlxslg1yr/0ahJnkn+Dxf7H75pmSxA
 SWKdBOUp3EM90S61WakxLcdBI7qMZwNDBebMjjGHvPsJGRFufioEJCTaui5u0pfk
 0G8jGYZvc55rwfzB4kwDqeSzg2jqB8DNXiy4c2AhIx0xBeSQHODjFxPqJLXwvgnx
 YRKljt8/r31d8vcCTAoAjWXIk1O6LgNKNhk9vByF14oEz/Amo4QXToSo9z7XZ8jy
 eDybm1LgMPU3pUD2us8OXru+YbZgh62TaYp0xEkpm5VD23fRcYHegbQrPF6lm7Hl
 m89Sw==
X-ME-Sender: <xms:FwyFaTSPuGpbN_n4kB0A-BwSxSuG7du52S1LZXELq_iNeqIW_XU5zA>
 <xme:FwyFafvPXeyccUKeN2oyJqPpCA4cIMSWmZ8h7JeRPqUZ9fPgbasVFEKHN3cg5oLG0
 xrovrVobXNA7LC_5E3k-6TWezr-EAhP6yOr5zx6uWXAn_YwBdhBeQ>
X-ME-Received: <xmr:FwyFaX2GOWBKdu1zfpV6KQSyvHOAcYs6GlWBXWMrq7LJHEYxF8YSSTDHYBNO-5v8mxZ4ZCjQH5ncpyhNtrpFSLAqNQZJJuk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeeifeelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpedvjefhudeghedvtdeijeeigeetuedugfejueekieeltdfhteevkeeh
 hfeilefhtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeejpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtph
 htthhopegurghvihgurdhmrghrtghhrghnugesrhgvughhrghtrdgtohhmpdhrtghpthht
 ohepshhtrggslhgvseguphgukhdrohhrghdprhgtphhtthhopehkihhshhhorhgvrdhprg
 gumhgrnhgrsghhrgessghrohgruggtohhmrdgtohhmpdhrtghpthhtoheprghjihhtrdhk
 hhgrphgrrhguvgessghrohgruggtohhmrdgtohhmpdhrtghpthhtohepshhrihhhrghrsh
 hhrgdrsggrshgrvhgrphgrthhnrgessghrohgruggtohhmrdgtohhmpdhrtghpthhtohep
 phgvthgvrhdrshhprhgvrggusghorhhouhhghhessghrohgruggtohhmrdgtohhm
X-ME-Proxy: <xmx:FwyFaYWVXAfISOzspiT2oSclMet87Rk8c_2sWMFsyGaZ1m3tnsULSA>
 <xmx:FwyFaaIDoWiZk8yQdQVHF9xrgPwmdAP6T2tF3Vml0hJQNL4scfhWvg>
 <xmx:FwyFaS2G2Zk2z-wI6d-JJNAM8drPUuZ_5-Le7yAz_lt8k85zgZlTqA>
 <xmx:FwyFaY5jW-95gJ6rSee84KTdgZT1Z2Up338oiBHs0UazVC6VqRO4cw>
 <xmx:GQyFaU5xp8T9-PbaLuUG3nrPIHzIp_JDvCRnk3Qm6m8dxba2m4mYMx8Q>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Feb 2026 16:31:02 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, stable@dpdk.org,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
 Peter Spreadborough <peter.spreadborough@broadcom.com>
Subject: [PATCH v4 07/11] net/bnxt/tf_ulp: fix minsize build
Date: Thu,  5 Feb 2026 22:27:39 +0100
Message-ID: <20260205213044.702908-8-thomas@monjalon.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260205213044.702908-1-thomas@monjalon.net>
References: <20210412215339.2439530-1-thomas@monjalon.net>
 <20260205213044.702908-1-thomas@monjalon.net>
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

This error is seen in build of type "minsize":

In function 'ulp_blob_append':
	error: 'num' may be used uninitialized [-Werror=maybe-uninitialized]
	drivers/net/bnxt/tf_ulp/ulp_utils.h:1109:13:
	note: in expansion of macro 'unlikely'
 1109 |         if (unlikely((src_offset + src_len) > num))
      |             ^~~~~~~~
drivers/net/bnxt/tf_ulp/ulp_utils.h:1105:18: note: 'num' was declared here
 1105 |         uint16_t num;

Indeed num may be not initialized if ulp_blob_data_get() fails.
It is fixed by checking the return value src_buf.

Fixes: 0c036a1485b9 ("net/bnxt/tf_ulp: optimize with inline and prediction")
Cc: stable@dpdk.org

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 drivers/net/bnxt/tf_ulp/ulp_utils.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/bnxt/tf_ulp/ulp_utils.h b/drivers/net/bnxt/tf_ulp/ulp_utils.h
index 7a8145b5df..ce20f1916f 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_utils.h
+++ b/drivers/net/bnxt/tf_ulp/ulp_utils.h
@@ -1106,6 +1106,8 @@ ulp_blob_append(struct ulp_blob *dst, struct ulp_blob *src,
 	uint8_t bluff;
 	uint8_t *src_buf = ulp_blob_data_get(src, &num);
 
+	if (unlikely(src_buf == NULL))
+		return -EINVAL;
 	if (unlikely((src_offset + src_len) > num))
 		return -EINVAL;
 
-- 
2.52.0

