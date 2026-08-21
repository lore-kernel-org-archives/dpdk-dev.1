Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40723C5DF8C
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:32:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C899F40ED0;
	Fri, 21 Aug 2026 21:31:09 +0200 (CEST)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by mails.dpdk.org (Postfix) with ESMTP id 9AF804067B
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:31:07 +0200 (CEST)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-cb5b8572b70so1760981a12.2
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340667;
 x=1787945467; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xc8mWfG14T8pk+ZRbvLkA+2dS/EZ3ZPSInLsvJxFjl0=;
 b=sdun/EOfrKhJCM3a/Pf4mvvyOvXppcl3ttSNUeHULvKn0jhEoPl9LHhkSkyryPCSBN
 jIFnBuMHuh5tqx68owVCmoeT/1dCaoUIv2YFOe9+qiAPtRW/oz24ke+zZJ24bbNbFmlr
 Ft1hqDUr8qhn/boaw7JRBo99Q4bRm4GuQHrItLbDEB64tk2yRzKUXh02OJ4RAWQ6zrz5
 SKSnXVudKNXaIZL3GLihvdCQXla+QXUHefVFihlF2oN3zU6lgddO77VBUiOuoKg+H8iR
 datU+NeYL4mp0pTCzO1jOzrHLtmn75zkEJZUcIjg9LXMkIXQ+knVwCOcMm3Nwf8xSgY5
 vfbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340667; x=1787945467;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xc8mWfG14T8pk+ZRbvLkA+2dS/EZ3ZPSInLsvJxFjl0=;
 b=boGvZjHjkrcXAxGjbmPyQYNL0X2OJBZ/VKRsR0rh3bh5tcMO2/7tiaumhT/GzCjyO8
 BzpCNphmYX1ca4TuVInUvp/Q911z24DO6a6+4uyHD/3DXP9tCejnkxZM7ivVIzxmiqVE
 7naCpjX+JVQSX8K5XpTnZ8pgG6lw+sPFLwpLMqfnJKj5NjRxBUXkfnEOQSus029NqjLI
 LygmJuafqiOQPUcKnv4Toz3vIXZ1Gi/uThWJlcIYgEdHWj3t66TSAjum7gG6VPTaISdH
 iBjPY4aTPuUV3G750PetI5XuskoL9HcHtneYsw4BWmSPSnAh8oV7XJ6SzWE74lJCRFZh
 5pUQ==
X-Gm-Message-State: AFuF++mpoTVCMllnmjFMViHZC/6vELIKaTNzth4wc4pdISuy9sxfNhmL
 J0a0H7lU3QP6Yah3y4OPCF5G/VHZ0jygLX6sgnOMst3EwGjYTe5+SfKUEG2K+bPY2ovsxq3hpN5
 jeAoQi74=
X-Gm-Gg: AR+sD13kxuiyX/y0s447nkZkSZZKYAfRwmD50W4ZiRMS1q1rgN0v6C8RvlbpwPMZF2i
 Sqd+BgwvicZsLB6ZJMfN5WoJJLKl4IUWScuGLfCV4UliT9LhTt4UGduCU5OpV+dAYZLthe3oMMw
 BSxUPau48ycN5pptsqWA+ubkYBxG6r4oMTBb2A8fTFK16ePNSJ2Cn1d8TNZ6lEbVKvHgvdYqI2n
 LRQVqZJp3UMXA6vpQKm7db76FzIuaxyMUe5VQ67QpvDlYN4NEOGT5OpBjSFbrM+Fw0fqCOh6s1M
 ljRF3ybD6HC7Nwj7oPgQ6TKL0XyZW0TNRVghjPo6suRnuU6HMGdJrNbfHToHAEoRiT48ZjIgzrb
 uNFp4ksTr99AWQAzh4ddUgJ6UJ12CJP3PAmzspEYvmEVsWYeUE3cNvxH8FHYVMaei/GuLSvHWyR
 vrVChomwqPkQzbom31ckZ6GIL0l8FrstpYFglTFmVLeqV+jZN5SxSSKpKfhM+D+NCKPXkBGM6DI
 LTq9/jOUvJNVdsH1XdUhsFLpmGhD8mgsjKkbvY=
X-Received: by 2002:a05:6a21:600c:b0:3b4:61f:1fec with SMTP id
 adf61e73a8af0-3cd2fd8e339mr18251912637.2.1787340666816; 
 Fri, 21 Aug 2026 12:31:06 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.31.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:31:06 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v2 54/68] net/ice: use memcpy for fixed size data
Date: Fri, 21 Aug 2026 12:24:49 -0700
Message-ID: <20260821192646.146382-55-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821192646.146382-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
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

