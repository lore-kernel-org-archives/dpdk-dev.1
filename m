Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EFEC79FB7
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Sep 2026 20:42:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A48FC4067D;
	Wed,  9 Sep 2026 22:42:17 +0200 (CEST)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50]) by mails.dpdk.org (Postfix) with ESMTP id A1B254067A
 for <dev@dpdk.org>; Wed,  9 Sep 2026 22:42:16 +0200 (CEST)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-398c1101c1bso6078096a91.1
 for <dev@dpdk.org>; Wed, 09 Sep 2026 13:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788986536;
 x=1789591336; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QrZLPnURtQZwMQgXU7iydU3/UldrSTMslAlbO2tSXVQ=;
 b=HU78zrPuETNzq5dmbYyQYs4KkC4EZbzUnlotEqd7cmmG6F7Sb5L29JS8UPYjpysBM3
 BUlCQdDXrhOxso92lG7oOELZgleVzLdz7PPcVN4z5zIGRb89xZ3tgnBqk/91zt5iLMsJ
 oxEID4DGeLXGPy80lK1gBTIvjyaLaxnOtnXMwigfl5LG3hlfraT+uVvEO5hitzNwys39
 8zoLK6tS1fymCasrjCmtRs2wTyolLz9czP4PaiM0YOyR6vIAPH0gvGfN1s9JroLRo/2N
 EiLL9+YmAuoZd40b9qeL2NBLwR1TX0S/2TbMDqIfbvk11W0QkAQFA02yyGMWDrgS7xTA
 iUKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788986536; x=1789591336;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QrZLPnURtQZwMQgXU7iydU3/UldrSTMslAlbO2tSXVQ=;
 b=IV3BvrIaJHXk7DVwe6F2mJX4239VCiUqnBZxBp4m7Q927RqaL9k/pNubAfxHKblwwH
 WM2XnRSFudozU0uTJH8pGF4wKlgd/EM9ydHPnqofpNg93HmsfnnUuQyXyu2WZWxTwsY3
 gAu1cqp87jzkisR6nZZBw7gzPsPzAaSb8o6w5LPLyF75f3u3ZkIiXmm1109eooWGwbmb
 4KNgXkIPr5cgyq37UFB4PoPBrnYIZ5o0YMVTXd9Bb08kM3eFWwRAVCbx8r3z59+BKItq
 HHs5GCzGut1MK5KrZACUmrYyHMpblyZTlxQLsX2nJzTGGJVR9lWwFAbGSNtBOZ2LSFna
 APUA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwmQu+kLWI2LkDECuRCA4LoUKe0Z4h4iGdyGxBeS3DmkDU4F2pm8mEHNHGJx616HyK3CKI=@dpdk.org
X-Gm-Message-State: AFuF++l/vnLXiUg52GPYZvoUFsl0/Qt1UnxiCcyKW0nsqq4gP0zPz1EA
 gpweuLtQ/+aCB0YmCUI3bRHCAJchZnNAcWg5tjPXz8zWucaZJDVhaQ10SEtkiuf/PSc=
X-Gm-Gg: AYBFou1UFq2qt6jHSkZb/LLS3ckDiTuAF3TB1L2uHxqxasoKlK2vrpydBOe4l+HrWFU
 JDqwuniKJ22M1Cgnl8ljtbXsU3UacC+AwDg0LUHD1bZgNksrt7i1snrxcqxx+E2SdcY9JEm3mpR
 gwI8d1zYbi91i043F2rvF0e41zh4IkSAHmD46CxKjMRLN8o4AQoRtdvjNOUc/YLH4hFlzluktPK
 5mcqBUQ78oFEhVI6V52iljRH65BBvFIbWYFFbinjURH4bdhRtt22TlDgqEytPd66JwCWdze5mVP
 HwnNKOc0TAA5Sz9cHiLApoQt45lZNvd1J6aYd0nxYBjS3rBh7/7/GHnfScHdZDMXgF2YXFuzOyN
 bm6E6+9ieNYUbgTZN2taRVo5d6K8oNYMtSBMlBtgVJrCwQdFJ34D4524ppwmme91UAkheK0qqWg
 mCEP5DsvOgCqzjolPa7ZgsUFg02rzCuUcSWoj23YMlvdxDu8nqKc8gqIIoLYxi6Em4uNNfCWvhg
 xEQOUdq5VLxiRD1IYfXse1CZvE3smS/7C3uPY+RHse5uXnctbU=
X-Received: by 2002:a17:90b:534e:b0:398:ba0e:96f6 with SMTP id
 98e67ed59e1d1-39b2624f0f4mr53594579a91.23.1788986535572; 
 Wed, 09 Sep 2026 13:42:15 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d770e3bf4sm1235696a91.7.2026.09.09.13.42.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 13:42:15 -0700 (PDT)
Date: Wed, 9 Sep 2026 13:42:05 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zhang Tengfei <zhtfdev@gmail.com>
Cc: Jiawen Wu <jiawenwu@trustnetic.com>, Zaiyu Wang
 <zaiyuwang@trustnetic.com>, dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH] net/txgbe: fix FDIR devarg integer width
Message-ID: <20260909134205.7470b8df@phoenix.local>
In-Reply-To: <20260909173946.16645-1-zhtfdev@gmail.com>
References: <20260909173946.16645-1-zhtfdev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Thu, 10 Sep 2026 01:39:46 +0800
Zhang Tengfei <zhtfdev@gmail.com> wrote:

> txgbe_handle_devarg() stores a uint16_t through extra_args, but
> pballoc and drop_queue were u8. Setting pkt-filter-size overwrote
> the adjacent drop_queue default.
> 
> Fixes: 7e18be9beef2 ("net/txgbe: add device arguments for FDIR")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Zhang Tengfei <zhtfdev@gmail.com>
> ---

Applied to next-net.
Review saw another issue in devarg handling, sent followup patch for that.
