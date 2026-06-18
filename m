Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595C3CD98ED
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 09:13:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A2AE540296;
	Thu, 18 Jun 2026 11:13:04 +0200 (CEST)
Received: from fout-b1-smtp.messagingengine.com
 (fout-b1-smtp.messagingengine.com [202.12.124.144])
 by mails.dpdk.org (Postfix) with ESMTP id 1447540268
 for <dev@dpdk.org>; Thu, 18 Jun 2026 11:13:04 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id DAFD71D00067;
 Thu, 18 Jun 2026 05:13:01 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Thu, 18 Jun 2026 05:13:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1781773981;
 x=1781860381; bh=QtIzVJ2qsSJYt1/oJazhWHktBZcDtSkP9sEreSy5lfA=; b=
 owr/rDBO6Xn8GEvWVEwVAdKCe2UBE4/rfZrhFBfRLyXynxMvqnvRfLqnEsi5vgm0
 xAuGkDWBC1EKO2/2emztrAOdkZ7AjXu6c1BOaPZEvyL8Dop0kYmmJqezsmxfGz9+
 VV1k7jZ/jFc0+5uJjAwAZd11Z8pvWyzn7XtAxIA8CA+4l46pP05XVLp8D72o9tbg
 9jFvng+w5KuOqOXxNMeA1NkwOJIg9T04snm1WhCEXAY/OLOLEjtNjVUfyxP7KQQ5
 WW4+XGZ5PBJnpF6DBKK2XKUGtJhKol/hWklz8liG/07nkbl3jNVBMSi0d89jHt4P
 z11YvllxnXpQA9KJJBFePg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781773981; x=
 1781860381; bh=QtIzVJ2qsSJYt1/oJazhWHktBZcDtSkP9sEreSy5lfA=; b=c
 kKxTaOYOwjHbikpXdQxAwp/lpLSykcJgkS+atPwVOW1sDga2x7sWkK4HBfgvubiz
 6V8Pfut1fPtUs30INV78BJWGcOrTYNrxamSFC9u11cIz/4kuXoDQYQV+7B1Z3SEK
 rr4RBrdtMNeicGDtxaEnG0P5Q/UUruRRoE2yno8dBiLoxjGFgUS3KA/XxXa//Pct
 /mghOQv8W988G2LDVd1qNlIsAJjkvNG4JKoaLUWW84OsS75qTze/TANzvmqxVadD
 oHRDRDzCmMPFm88F0pVTdUB4Vvj1Q53ewFYDY1Eozy/ELeXTW6DJxxWT5T7p+JCV
 K1l7QceTF/Zc+zdZpKSUA==
X-ME-Sender: <xms:nbYzasgpo1eRHFyugg6G7HyteL2zCRLT4AtXkTvPNlduA6bhQcCXnw>
 <xme:nbYzai_CmzI20UC9xhWjbrun32-2ibUK6XPxgSMJJghCvnXHFv2FR3hGs7MGwNRdk
 9x8Uy4JLG7YiYAIazPl4t2Tqkpl-zZR8QU-1-_I7c-LAY7YPrkSWA>
X-ME-Received: <xmr:nbYzamYpjTmJYGnfsZewlPKQGEfJfuq0RgyAYamCURqCcwGUR1-McDmB7ZGWKyOq_1lYt2iZlwgSYFfF9vcaiH7bxQ>
X-ME-Proxy-Cause: dmFkZTGl24gxmFcwc5XGm3EASdmt6PMfLmpH6StQmy8PE/BNz64JHTSPLPHyaKr53/90yc
 Ry8dcx4ZPMlW7Xlu8wUIw4lJZhFrwmv8+BlNvF8SluWJMo6evnS6MNbMhp2LP4BvR/JLqw
 qBRUOU01taSWPjDPeT/11Qrq9J5nedIpSwY9ztFMQvfLJDSQ4/jNGBLQVzzV4ACnMPLx19
 fa+6NEMpABjM3+n0U/VvnXxX17+aaw62UWucwa/PDqvupe+fhyi5JmPIqYXB8AhDxjQzgj
 pE6av6KB99vXzp20rvft9hwQhPrAvNfnZDM4oVaSLS8hzSNNOw3YCLB5jpbxDwZ1Jgr5oG
 uUueVgQQPZLCp4q6cF5S3OmsfXkT4HsA9BpSrFyLjllAOkMkTX0EVctd0UztprwsYIyCdW
 Gec7SgXfzrNlewijBJROBl1Bbcb5YbVJlnZqsy5KvnkkIYV1OnxyAEFfMPDWzgmFyB7ey1
 ERH6P48gcySGEaPui5UwopDiattkTuzIi01rz/D5GDPmtwS0r1asCK3P0pRlqc+nxC+ywi
 IeNSak2FF38yfp4DCJWug4i1ZLUo85qFOIjHpHlcHfdxCakp6V0V+peeAZtCEL2ZHkRXkJ
 S7bI8b4hlNN7xEhXIC5HQ1i2FaN860AxEB1ayeyGTC/sZuZK+bO3ZUmOzNiA
X-ME-Proxy: <xmx:nbYzah2fFzvGSl0ggV3K3if5ie4gh8xQCtGpr7PxNHx8UW7LmwCHaQ>
 <xmx:nbYzahY9rBpeSWj8s5xe0TCPfsugXTe1k_dS7j5UxFf3xOci9Q7cKg>
 <xmx:nbYzapKV9eTDilnLjZRxEQX-QcTy1-LhnqCQKjRmsHhURRJpqViPXw>
 <xmx:nbYzagH6uS4jXifuhzEcIkQqjfJldDMuEjnPQx77k-QV_tELXCGHRQ>
 <xmx:nbYzageE64N_07eT-wdtzk-0SchffwiObu6ngcSo0DhzGDrSNz1HaWzo>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jun 2026 05:13:00 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>
Subject: Re: [PATCH v2 12/23] examples/vm_power_manage: enable shadow warnings
Date: Thu, 18 Jun 2026 11:12:57 +0200
Message-ID: <z0IQFk2sS_2ltp9U4Sbr9Q@monjalon.net>
In-Reply-To: <20260407151732.272195-13-stephen@networkplumber.org>
References: <20260407035209.650419-1-stephen@networkplumber.org>
 <20260407151732.272195-1-stephen@networkplumber.org>
 <20260407151732.272195-13-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

07/04/2026 17:16, Stephen Hemminger:
> No problems in this code, re-enable the warning.

Actually, there are a lot of variables ret defined multiple times
in the same function.


