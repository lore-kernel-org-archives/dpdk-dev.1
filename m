Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1233BC55ABA
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 03:26:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E633F40664;
	Thu,  6 Aug 2026 05:25:53 +0200 (CEST)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mails.dpdk.org (Postfix) with ESMTP id D216040616
 for <dev@dpdk.org>; Thu,  6 Aug 2026 05:25:51 +0200 (CEST)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2cf6d65d8a7so25524715ad.0
 for <dev@dpdk.org>; Wed, 05 Aug 2026 20:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785986751;
 x=1786591551; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zFZDpG4eV0HCHZKgDiuGv3S4hmSfbHtRtepgmSaR2HI=;
 b=temy0DB3eAOI1navC55DASd/ssd4i6FV+GMR96pqRF5DUEHnS9wDrs4CmZBotxbq2T
 n+0KAPmX2itWip3CuLEycEIS/OEIaC4WqNojC0YSc+5GUppCqTvVc/VUIap4yvikNjxy
 aQc9cHfhPXfBBIO0NL7Z87oluIwzMhIOeLCDL/cYsnSuxJrG0tugGiUrIs0zPd6xAHqI
 eDM5BUO/lIVtfmBTnqfjHgKvm7Xa7xqkwkWzzKvo0W0I9CtC3huqIGJ54bT2xJjWspjh
 j8UuanaXVhEw2aAL5aH21u+sj2MvsOb0JDeex03e2bLt1G/g0DDC7ccKcbX3R+UjkLLr
 clbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785986751; x=1786591551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zFZDpG4eV0HCHZKgDiuGv3S4hmSfbHtRtepgmSaR2HI=;
 b=jTHmijuDjDaIiMJKwtwkEVMGDvyW3WJh4eqSyEJgaqc4gisQl+KIdBO+pTa3t629oL
 TUekHVmzg9vrQDrk/RIhs+6PpCvS3wT5JM0oMbn+IjozZru9HAzomczfiCU9ZPZJXLV5
 oOpxzfHToeisDrXIHc4MFOWZ3DUPnZraZfhbRRoxxRj4Mgm25MkpABA3y9EFJ+FMT6n3
 zpSKvywIISAOesfbGzG1Kjdgy0ONho3Iyx1SZSSX8S5ciljNs2XYiHbcUEJ1QhTEvhsg
 zpe3pKgbXKLmN85X0wKN89CTL/u4rOEUG5JrM7pn4FAqVxOUimBOMhQBCI2TsmpQY8Zy
 PvFw==
X-Gm-Message-State: AOJu0Yxc7oI5P8ZUzR93HqAmeIXhpOXaGJBos0LS1rYYR5/JlbGqUlO7
 20+fTon4T3MLNxwgVO8lKEAeWnzFxQZcmJCG7+9qgHyjCnLxBRtpIBSQUasw8uWoSzRuoosZ3eM
 SOrTrwug=
X-Gm-Gg: AR+sD13EhZcxs6nk0edbj44rPiznf7Jucyu3slxYvV2gUaomle4+md8tG3kagWcx+gO
 AK9ahOKrge4ScurYmkK9O/7PsSE2MTFleT/jfZuiVpdiVDYeEN7OebMnhlDRuA0mX2OUgoTIR+H
 De9lBsvPVDrz4aqmbMda9WaMTXLMdIVh4aI7dK79WE8AjJoTgIsVtIZePMTNRs+tRt+NvIIq4Aj
 gwKZDu37/4wF/Vd1JkOQTLs5h+20soLDxo/OH+Af5JZbgJRxmLLyHhfbvd1SYoDkaZHBI8KbQ49
 yz6amxye4JTDeF/ET+wXyJXKynd/CZEYWfzxIm7wCq6wLI5E8EcIhwhcL0ktuxLhmrndiRRu5CE
 R75YhwjiFGvXTLwpyn8iEvfRREjRo7Pi90mngb+VcOGa8/KUr9LmJRIBtSVUAQWlINzXz71WeFQ
 JrCQzTltSYQKEbWarNs5Pb8z6ydQSL7pIvkAScLbY9Iu1r0OqCdktcv+3+VhaJQZ7wurr+RbWyf
 3ffoSXz+6y7Gf+Wfzh6+xO3Zn9NK2VXJZ0WDfI=
X-Received: by 2002:a17:90b:5111:b0:38e:64b0:8bce with SMTP id
 98e67ed59e1d1-3903c633720mr13006557a91.20.1785986750921; 
 Wed, 05 Aug 2026 20:25:50 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315863b0c61sm23301631eec.6.2026.08.05.20.25.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 20:25:50 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Dimon Zhao <dimon.zhao@nebula-matrix.com>,
 Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v7 03/24] net/nbl: remove unused rte_atomic16 field
Date: Wed,  5 Aug 2026 20:22:55 -0700
Message-ID: <20260806032544.21337-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806032544.21337-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260806032544.21337-1-stephen@networkplumber.org>
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

The tx_current_queue was defined as rte_atomic16_t which
is deprecated. Remove it since it was never used.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/nbl/nbl_hw/nbl_resource.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/nbl/nbl_hw/nbl_resource.h b/drivers/net/nbl/nbl_hw/nbl_resource.h
index bf5a9461f5..f2182ba6bc 100644
--- a/drivers/net/nbl/nbl_hw/nbl_resource.h
+++ b/drivers/net/nbl/nbl_hw/nbl_resource.h
@@ -225,7 +225,6 @@ struct nbl_res_info {
 	u16 base_qid;
 	u16 lcore_max;
 	u16 *pf_qid_to_lcore_id;
-	rte_atomic16_t tx_current_queue;
 };
 
 struct nbl_resource_mgt {
-- 
2.53.0

