Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04CEC44501
	for <dpdk-dev@archiver.kernel.org>; Sun, 12 Jul 2026 15:49:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F91D402A7;
	Sun, 12 Jul 2026 17:49:45 +0200 (CEST)
Received: from fout-a4-smtp.messagingengine.com
 (fout-a4-smtp.messagingengine.com [103.168.172.147])
 by mails.dpdk.org (Postfix) with ESMTP id 75A7F4013F
 for <dev@dpdk.org>; Sun, 12 Jul 2026 17:49:44 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id CFE38EC0100;
 Sun, 12 Jul 2026 11:49:43 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Sun, 12 Jul 2026 11:49:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1783871383;
 x=1783957783; bh=5GZBOMvLTpngIcCQHUyERUQrvrbGIYBColaHTLmQuCA=; b=
 dTCWtU9/a6fY1zy2U4UlJVQ7VoWLVxbG2V7OFV/edYH0IOQkKfAfXfYp7brF+xlQ
 Hu4SMYn5IDVCgmkOtH5hYLYylbkNa2OvruAlcM8t0gayLJJWYXDwSlDTKxRZl7yc
 MPRSedkd5GrBC80b+5I2Ai5p2ViKNgnc5OtCfC8uRsUXWIBiQ5muB5DuUZBYGU70
 Tshl9aQjo1hcXCtVbrNhzejMLEFWAMF3zk4eHb46nZsM8lEgWyNdWKxgE6biEBgj
 WojrjiV07VhghR8PKiA68UKZVXGr2EWtpoDgtCPBzkcIDgy/UwpqDsUnQSM5bLX/
 ARfUTO2aFqyfmnjJCRQeOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783871383; x=
 1783957783; bh=5GZBOMvLTpngIcCQHUyERUQrvrbGIYBColaHTLmQuCA=; b=N
 jUtzXnWGzA0fxDHRTaKqBcfcDrCh22ipLRQ8bcr4aLGYc5f1rf6y2XVSsX1oM7LE
 ykX8tgjrXASWOiOJUl3ItQuEg0R8NcyHdIzECSc357hjYu+wQ0rYbQftkWJE64CA
 QCzwEFxJccIUfF1ASsNwM/M5wAJQrzfTZmUy1uONIeK/IItKnOZ3oMsij99l3UIk
 v8KC85EPsdttOLYUZh5CU5NS9x8wXy6uLLfB3FfqpTWHLGzVEnQskhw2/gmL5PjV
 cPkg5bfK4a1gFN6wnpaQGg7FZbWT3qJtLemWQgroUM6Hh2dMTHW+Aq7hO0qWHTp4
 VQiAgdDjeGDyxAQNwDD7w==
X-ME-Sender: <xms:l7dTaghhf2fVEsru2QoZ1hPvytkx4IdTy3BEPebw0YlwlR6MPPQOtw>
 <xme:l7dTakfOXzSGl4yf5gGAW3RbA05JrWuafIlbWAXcJfRLd2aQGvmmPshDozOTuFl9s
 Qk997z2tLg8kDrNfNUoNlfU28CvWH-5vO2Ily_WGPMLHrzPYt-FtQ>
X-ME-Received: <xmr:l7dTarmxfaP5jDOZBO341pn4x7lC6XPtuSS5_Wj9jHhrUAe97C_0pxt6esCTKZgdKtTRGbRuwjkQ1RiQHeFjWeo>
X-ME-Proxy-Cause: dmFkZTFgkBSN4NBRSqObZtA/MvNLEKTu3rYOcpZP2QX4Mp6iK3JcMjyUXfLOpmo/De6/Da
 EyklZTEtTjf07rrRJ3nWmE8J5zPIM6eACRKx/N1R9gXrtMUtcMdzfFjfqWqtIsP7ydGwZg
 hSdywFxygdidaAlnk1K3y05dv+sb2cWzsH7XG0ZJc/HSEWVIkuo0ytDoXlQCK4wZSAxzuk
 /FlwIaxDFgCLxaumD6oc4KiiGxxooPq3W4NWlQJHvtyY+oN5ybSMmF4Vz/yTK4o8xFcptd
 WZLthqGkRFMKadpTVJt+O4HuSTmJ0SeDpuzk68poGWs26H143X46uNduZnlnOO73dGYzKD
 j+ewoSepzI0txqRq+c0xS1U4MYQyj85MwFpXhPWk64LUfr36L1vvHOnYvYB2fWIgQHZwnQ
 gnRBEz82XMCY+ys+mitRPRcW5UfwhS+A44+8zVBvzO4mMdnjdMcXo9Yr+K16Uxfr68Hx+E
 /78Ukav2B25lzjN/tGKLvJkJOr9vLqrT6PQ42TdmN1KbJyCad3jpru64McfpKUCZeMNHdT
 O+8uliVWX8fD5OOUiXjSE43RALM6bcAQl/dTaJJvKh742O0Lo0f7U0kVsjBePXOY+leLh7
 jnBpXopI2nYvDrxR/cGreU2XlCiHsJPp0SbDOqJ7s56ZhMhmlm3cQsOPZBvQ
X-ME-Proxy: <xmx:l7dTalvI6ekOkEepFmHb_Hawl0VbXr-a9bL2cE3xIafpwxai1WToHw>
 <xmx:l7dTap-jguO1k6nCvtawv0wy9jrg8uwPKtYXNyW8HTIO-GIaUKbfRA>
 <xmx:l7dTavOu1XuXaFbs2mEEFgp-RlGfpO5m3VGGkZZJm_nlqFWIvF112g>
 <xmx:l7dTanGMQ-wiLoNbMfIjrG-7l2Mo28gY_E71RQopULH7qQiIiJOrLA>
 <xmx:l7dTaooH-eofKuGqIfq-Fin92Gj9lozhjyF9ayD-MumWrRhDmEuDRu2c>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 12 Jul 2026 11:49:41 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, konstantin.ananyev@huawei.com, vladimir.medvedkin@intel.com, 
 Aaron Conole <aconole@redhat.com>
Subject: Re: [PATCH] AGENTS.md: add additional checks for crypto related code
Date: Sun, 12 Jul 2026 17:49:38 +0200
Message-ID: <_A8u46MgQQuCAo2fxGs2lg@monjalon.net>
In-Reply-To: <20260625230536.147975-1-stephen@networkplumber.org>
References: <20260625230536.147975-1-stephen@networkplumber.org>
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

26/06/2026 01:05, Stephen Hemminger:
> Security related code is a high value target and extra precautions
> should be taken. These are hard to catch with checkpatch alone
> so add additional rules to AGENTS file.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Applied, thanks.



