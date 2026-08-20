Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3281C5DF81
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 05:27:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D93D740E43;
	Thu, 20 Aug 2026 07:25:58 +0200 (CEST)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by mails.dpdk.org (Postfix) with ESMTP id C0BE640E3B
 for <dev@dpdk.org>; Thu, 20 Aug 2026 07:25:53 +0200 (CEST)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-c96b08cdd1cso1177212a12.0
 for <dev@dpdk.org>; Wed, 19 Aug 2026 22:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787203553;
 x=1787808353; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xc8mWfG14T8pk+ZRbvLkA+2dS/EZ3ZPSInLsvJxFjl0=;
 b=GhEUwIYe+kBrGkXyks1i5RewsjUkq8pjfKAT1XR6OCccOVWJcMgUayE4cg2Z+WE7EB
 C6PrHOmNmPGrxBgtLkuKEaiTX+GP2W2wXrlUhfS9IQE6mQVes7uA1Ub9hU/51HLCp53z
 G+Nab0raHPCBYK/0ue3lEzJtf3yH6tj2+98qA64Nd4zO1Vjrl08nHCzQltXxEQ8/nlbH
 JYjICxVPrMabxJXkDV8LoiK/MEgMTvEr6YunYpAw7eShxtEzJtpQPR9A3OBSJrx6Ts6a
 qXD75LjOUXyYd7vCTfjRms2X5ckIg+hTxjuFH/R/9OQQK+7X8+3jzxK5IhlVBM525nRa
 Q/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787203553; x=1787808353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xc8mWfG14T8pk+ZRbvLkA+2dS/EZ3ZPSInLsvJxFjl0=;
 b=JzL4O17x2VQT5WIulynKu5IMfHofToG6ooRRVrbxhps1ZC98R5fLbBVbv4L/rXKvWS
 lxaGUS64miBwrILgqoRojrF2ldZBwhHpttfg4b6zkBxdvqKdhi4zzXLJhnohAgXOzzIL
 Vv0lS9FDrq/6H/xvl14iERxsXj/F8q4lA1TAX/P2O5IbQXKB2omjPiuej/1erwRiDrSK
 G9TGxfj5fpGo7Qaomwgsu94k9gxkvkdpibpPFlwpXRva3oNkHPnyvtNZwklxkK1QeiWw
 eF3q+amn5gzuoQtVCW4Bm+YInqdVxdBMIHU9CN88z5XvKIY5o9pdT0rmxMr/STJqQAnY
 dCFQ==
X-Gm-Message-State: AFuF++mTiRxMPkk/bmYlrwdHqILnw3/n1PZU/QIMFY9cpfC8ImaqkZoI
 EqypmKvAENa9K/HjyUcf45g43yV6EkZJNLq+IvN7Ti1xZiHgfy4aJX02xeMkpPlhF1RWf2vyPrP
 hUhKH
X-Gm-Gg: AR+sD12jmGf7Wm0cUFeEwKFoweCF6MVXaPQJ9OgCpohsT4Zhw1AT7mZ3LusFLftKyUE
 wT8YRf8/w/1oDktWwRxpWj6VGhf1+zwurDVhH4W40LrIvkVv9EfbfwIR1TFIn+nBuTORsC+Dkco
 RseSv20eatTManyehq9Y1hPLmfoayBadWENgauvD+WPgGYkxrI3D4fRIGIFeVD/mMoI+q2wLRe0
 GzvajZwqphJFznw+BQv4dJWLwepLEhdZj4TvQlQnr8OTfdwIQkTOHPxbXqEm/8B9uMB/mizCa2O
 zq2QtGa3yk7d+WKi89/cAZDgEwYPT7zYerh8+NNEyHErqB8JNYDknPPA4YIGOJPJruFSjljNi0G
 McmDnUKTd2gmgPB3fidi9qyHpoKYJNDuKgd+be3h/FZAaiEc+PuGaYINJ2DCQg6DXPNNu7iyEYa
 MHVBa0FaAAqPIncn5S+VYPXnk34utsh+VaNuAqcXgNk8Y0k+FLdY2fYPN3x2iCR2sYJwYTTx1FJ
 LSAA6fFMh634AMdVNXW6OumTA0=
X-Received: by 2002:a17:90b:4d83:b0:381:1c96:829b with SMTP id
 98e67ed59e1d1-39580eda10bmr18064984a91.3.1787203552776; 
 Wed, 19 Aug 2026 22:25:52 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3bb5csm13700974eec.2.2026.08.19.22.25.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 22:25:49 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH 47/61] net/ice: use memcpy for fixed size data
Date: Wed, 19 Aug 2026 22:12:37 -0700
Message-ID: <20260820052251.1453273-48-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820052251.1453273-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
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

The regular libc memcpy is inline for fix sizes and has
better analysis coverage.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/intel/ice/ice_fdir_filter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/ice/ice_fdir_filter.c b/drivers/net/intel/ice/ice_fdir_filter.c
index d7ddd32f90..6d6fa04e72 100644
--- a/drivers/net/intel/ice/ice_fdir_filter.c
+++ b/drivers/net/intel/ice/ice_fdir_filter.c
@@ -2873,8 +2873,8 @@ ice_fdir_parse_action(struct ice_adapter *ad,
 			const struct rte_flow_action_count *act_count = act->conf;
 
 			filter->input.cnt_ena = ICE_FXD_FLTR_QW0_STAT_ENA_PKTS;
-			rte_memcpy(&filter->act_count, act_count,
-						sizeof(filter->act_count));
+			memcpy(&filter->act_count, act_count,
+			       sizeof(filter->act_count));
 			break;
 		}
 		default:
-- 
2.53.0

