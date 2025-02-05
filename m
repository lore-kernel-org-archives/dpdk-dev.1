Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C380AC02197
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 16:25:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D1B34064C;
	Wed,  5 Feb 2025 17:25:06 +0100 (CET)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49]) by mails.dpdk.org (Postfix) with ESMTP id 23488402EE
 for <dev@dpdk.org>; Wed,  5 Feb 2025 17:25:03 +0100 (CET)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-2f9b9c0088fso1848735a91.0
 for <dev@dpdk.org>; Wed, 05 Feb 2025 08:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1738772702;
 x=1739377502; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S+P0iRQIN7Ddu4uuVC6PGL7SifUHeSC7BEdThlMrW64=;
 b=CEwrfbRSnjQpSSkNQOxhihDKOykJVH1Cbwk7sALikvNMVQq7S2Y/84pcH4lonxewaX
 fUXe0ZxSGhl0XKDQxRx4/baUmsqnMJQ7eOVoV6tQtSYB0wrgBM3bAqwNFwyt1DDlxC03
 H63ZKndwTWLixaXIjSt9YZ46KtW2Bpev6NM7EIwZkTfhexAS7qxeZK/gfieNsyZHaVeZ
 jgkEo9Jp2MM4xuxwY8kMeHRnLyhKhC16WupMWVcs+r6cy9DmVHTJJPVzBhLAQHHpejjM
 8ozCcMgZVccUq/6FPexG0l/ECOtCPYygZkKRVb0246OpyE2nlWnZB6x/GlAgwvTk5tXe
 cUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738772702; x=1739377502;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S+P0iRQIN7Ddu4uuVC6PGL7SifUHeSC7BEdThlMrW64=;
 b=qZWfXpTtH5juuTITErNbf3S8Lc76zKYmg32G88HCqp3xjN1DLJPtrx4iA+gnPIG5iP
 gGdvgK0K6qeuWj/rXPAW+lCo7313Hq0oWOSHEDQbXsMKMH5kCuBNQHd1ScpuB9WE5fXH
 olIBBY6Um8ahjiCVDk8+bJBZnrDcx1ng2uPiub+zXZw2EbN6odvhfrrm3tm3q8h2Rsof
 EOPUREj49zyn8lhzTeYwCCa89bR38+24LSOMh0IDAwFd+XKYN1karHkC5WL0rX7B++vR
 8IUT5NuwxJ8d8EpHJms5/LTsOoxqqonn8L1IZjFea1eyW7IJZ81p3F7tSraK9l7be61k
 ts/w==
X-Gm-Message-State: AOJu0YydVl9LvG3dk61/Pp2/Uuo0UDYxALZM+1lRy2ok21nLRBgqyh1n
 pCy1MthoLzs5/jxNLdrSPanQ7seVhAwP56ReeAc8DiLnONHo+SpHy35l4/UdcIKAbU0gu/Lx3Y8
 x
X-Gm-Gg: ASbGncvyPKuB+W8oXi15JaV22K6Jj4o8/9TyoY6AZjEY8Sohs6SFQlHMjfCT5Sbss3n
 7A2Fgl7hIBtMz9OFXC6uEZBWLaqfahoTcAQt0bGX9oHlRuabcZCABX51MCgzDGzWnXLddjixbvB
 VITesgu5dtzkUSQRaeRp0FT3y2S554xYD6Ivu3IuR7rqzxq6uYa8sQyOzEglQv9m+rUoEvGmfm8
 0lUA2Ix10zvDesVi2eJ4kpXh4kJUWqh/Sl+7JaRn0KPwjVDKFBRfzpzizvwrAc3Q4oripJOV3vC
 Cf5QHC7Ybb6iwSz53g0BmGWrhtwuQn4x6Zrj8NdAlKglzHd0JeQbiw00M//NMqGyfm2c
X-Google-Smtp-Source: AGHT+IEggT8cR9kBSwBuhMLWZjuoQrgy60OVFwM6XVQ7J070FQciws9io/lWuFnkWrBsWACLy4hIQw==
X-Received: by 2002:a17:90a:d44d:b0:2ee:edae:775 with SMTP id
 98e67ed59e1d1-2f9fddaab98mr129158a91.3.1738772700802; 
 Wed, 05 Feb 2025 08:25:00 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f9c314b64fsm2138965a91.1.2025.02.05.08.25.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 08:25:00 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anoob Joseph <anoobj@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>
Subject: [PATCH v3 01/19] common/cnxk: remove duplicate condition
Date: Wed,  5 Feb 2025 08:23:02 -0800
Message-ID: <20250205162448.161161-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250205162448.161161-1-stephen@networkplumber.org>
References: <20241115060738.313190-1-stephen@networkplumber.org>
 <20250205162448.161161-1-stephen@networkplumber.org>
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

The same condition is checked twice in an if statement.
Harmless, but redundant.

Link: https://pvs-studio.com/en/blog/posts/cpp/1183/

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Anoob Joseph <anoobj@marvell.com>
---
 drivers/common/cnxk/cnxk_security.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/common/cnxk/cnxk_security.c b/drivers/common/cnxk/cnxk_security.c
index c2871ad2bd..9446c14ac8 100644
--- a/drivers/common/cnxk/cnxk_security.c
+++ b/drivers/common/cnxk/cnxk_security.c
@@ -174,9 +174,11 @@ ot_ipsec_sa_common_param_fill(union roc_ot_ipsec_sa_word2 *w2, uint8_t *cipher_k
 	}
 
 	/* Set AES key length */
-	if (w2->s.enc_type == ROC_IE_SA_ENC_AES_CBC || w2->s.enc_type == ROC_IE_SA_ENC_AES_CCM ||
-	    w2->s.enc_type == ROC_IE_SA_ENC_AES_CTR || w2->s.enc_type == ROC_IE_SA_ENC_AES_GCM ||
-	    w2->s.enc_type == ROC_IE_SA_ENC_AES_CCM || w2->s.auth_type == ROC_IE_SA_AUTH_AES_GMAC) {
+	if (w2->s.enc_type == ROC_IE_SA_ENC_AES_CBC ||
+	    w2->s.enc_type == ROC_IE_SA_ENC_AES_CTR ||
+	    w2->s.enc_type == ROC_IE_SA_ENC_AES_GCM ||
+	    w2->s.enc_type == ROC_IE_SA_ENC_AES_CCM ||
+	    w2->s.auth_type == ROC_IE_SA_AUTH_AES_GMAC) {
 		switch (length) {
 		case ROC_CPT_AES128_KEY_LEN:
 			w2->s.aes_key_len = ROC_IE_SA_AES_KEY_LEN_128;
@@ -879,9 +881,11 @@ on_ipsec_sa_ctl_set(struct rte_security_ipsec_xform *ipsec,
 	}
 
 	/* Set AES key length */
-	if (ctl->enc_type == ROC_IE_SA_ENC_AES_CBC || ctl->enc_type == ROC_IE_SA_ENC_AES_CCM ||
-	    ctl->enc_type == ROC_IE_SA_ENC_AES_CTR || ctl->enc_type == ROC_IE_SA_ENC_AES_GCM ||
-	    ctl->enc_type == ROC_IE_SA_ENC_AES_CCM || ctl->auth_type == ROC_IE_SA_AUTH_AES_GMAC) {
+	if (ctl->enc_type == ROC_IE_SA_ENC_AES_CBC ||
+	    ctl->enc_type == ROC_IE_SA_ENC_AES_CTR ||
+	    ctl->enc_type == ROC_IE_SA_ENC_AES_GCM ||
+	    ctl->enc_type == ROC_IE_SA_ENC_AES_CCM ||
+	    ctl->auth_type == ROC_IE_SA_AUTH_AES_GMAC) {
 		switch (aes_key_len) {
 		case 16:
 			ctl->aes_key_len = ROC_IE_SA_AES_KEY_LEN_128;
-- 
2.47.2

