Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FA8CD98ED
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 09:20:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 61EE240296;
	Thu, 18 Jun 2026 11:20:42 +0200 (CEST)
Received: from fout-b1-smtp.messagingengine.com
 (fout-b1-smtp.messagingengine.com [202.12.124.144])
 by mails.dpdk.org (Postfix) with ESMTP id 9419440268
 for <dev@dpdk.org>; Thu, 18 Jun 2026 11:20:41 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id D5E191D0012F;
 Thu, 18 Jun 2026 05:20:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Thu, 18 Jun 2026 05:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1781774438;
 x=1781860838; bh=4IUrWUrGSbInXjbGTYBgsp9ZVPautniIZW/RkDrF5P4=; b=
 YHWxC9BQTap02PqZKur/Ahf8Pm51Qp8ORycPWEhX+TbcYnC1keIZESFpdB2FZlwn
 E6XdIj9MqzAL7DP71Ys1D9+guNWqQjas1PBKQx7Xo0VNBrI4jvrXU346ClRCCqcd
 XEXghRYtezNIpWEcgpGD8K/aKzUirHWLut7DRTqx1pLP9f3X491wYoG1Eq87g8bO
 4g2FCDKcYRA7UZjRv2lEuv9Djn9mF/bzC6VmtmVtbaq8elHHHerRe4BZvPkip4od
 /AuZS5iKs0/DSUxOz0CIVFXgOna9EthJ45czqfr/qjOkryLAoIrKE3LHK9Frqk4f
 dSqiAQPrSXJW/hn8m9E8Vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781774438; x=
 1781860838; bh=4IUrWUrGSbInXjbGTYBgsp9ZVPautniIZW/RkDrF5P4=; b=j
 oqT04kHTftcaMAiUD4dpkZA3Gs5DQcZOZrMMooxrMFCT7RwI9wlS/BSGBiKqjS88
 aHOvevwxf0tDMoa1LPe/9KzdfQPZ+y0PGnxdxD5sWiSGNVq3ouGbv2oHmoRUPBTN
 saU/FZlCna4cYk9SS6b3FwRLUczdWrHRAWU10QMzE2FPPTIBd57uwCH2YhnujVWU
 0gtKtTTal3JxO0I7c2EUVKFxUiQm8kKu3D6ddEE2G9DysWKIPEQ4eW3o1DJx2TqY
 ki3ARzqP1aOHyeBb37S+GV9fWyVxC4F3kPtX8UOFaBnyMqkxCD8XchXqIAUTS6wS
 Y5xlsPMIJEaFGc9qvshdA==
X-ME-Sender: <xms:ZrgzaqcwfuvkH8A5_q4O3CtIpW-9B6p8fhzib7b0tEpguxVbu-Cxsg>
 <xme:ZrgzapnUT9ht97xHhCmoKlZRbM_ra_vHJicNqRD5zd5LxSINWiw9KnokYvCr3AKRK
 9mENDxwgTRw_vEgAQYtgtCDZ2yXHdfg6VmTFqdPu2dGVQ3TpnugWUU>
X-ME-Received: <xmr:ZrgzarvhN5lqDiI6NnTAaaZ7BJz5tispd_I1S_wCPlviLDA9gcTuHGaLWaGCH8x3xwap-5GfZlp2Kug6EdUgzIrE7g>
X-ME-Proxy-Cause: dmFkZTFkHfASk8yobF/KvscNzqnwnqxwyn/NXk6hF/T8hPJj3QwMQMNqLhNy6gQf6tl7m4
 /iybhB54F6cxCDsg7EFTrnF7CV/jxHISsAyGvPzex/MhsUyJYE0EMAH9hylVA79RtC3Xsv
 NeFbg49xLvT835RHp+I4UsoR6v0ideQQmUXvE8yqcoDs99xZorD0u3PNicFjKq4ppG8BJQ
 Z8jJirK/XNSXnRLMuUgPCiWCfuEYg1I9Xb5igdLp/FgwqhVRAV4ePXZOHKB9BfnAIC9REA
 qz+if3ywCJzILcjTaixfj677D9HYrSQlU9uSph84Z0/yPvQl6y6bqEkZJs2g+GJOUNWEqS
 hDkX3I2/Mc1aNcUi94SCdupVdOY0zHRDHgK1C2SyNYGLxoqat9qM41QDMTRxtpxgUTNdiQ
 6+9R9O4AxbIfRQbYZfaOQP6SrIZX0uKVR9IgBxSYNCAkZowLW6bMMD7MjupW5tG6jHvAjc
 vSrW/Zvdv2gml1pCfcnBOAnxQZjpezbZAPNPRNhoiuudAJ4JQJFKR/qjdNqY1aXVM5aTKB
 GRZQ1YyRnKyG0+T8qBnM/ojLXwDpY7Dwt71CcUYbkYAd5r5hHXJYhpOl93dvZgwiqJBYkd
 zGXksUPkiHMhMwJcILmy+nAZyVhnXDhR+5AGgYsb+RCT88osUFtiOJZr3gqQ
X-ME-Proxy: <xmx:Zrgzan-xD1clhDdfDyIlVo3Yqe6ITEWh3BJuWeVI5X4t_Qoogt5Xzg>
 <xmx:ZrgzalPX23P18CayyoJxB32LNjFA5f1kVD8Lplt538GCZLFECQ34sQ>
 <xmx:ZrgzalH9qIfHL8qGln-i3cJ4mCWM7wrRAQKenC6J6KDJVDaa8A_v6g>
 <xmx:ZrgzajT7Ml8ncQmCmllwiX9yf7BUDzI6HBUcc_aBt0LkBVFruyteAA>
 <xmx:ZrgzageuKfPsmKPe1pbHwBHosZuVjPOTJ1JJSZZV5alC1YowXz0HdO1k>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jun 2026 05:20:37 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Radu Nicolau <radu.nicolau@intel.com>, Akhil Goyal <gakhil@marvell.com>
Subject: Re: [PATCH v2 09/23] examples/ipsec-secgw: resolve shadowed variable
 warnings
Date: Thu, 18 Jun 2026 11:20:36 +0200
Message-ID: <S0plvKIjQ4ufoB1fJelRcw@monjalon.net>
In-Reply-To: <20260407151732.272195-10-stephen@networkplumber.org>
References: <20260407035209.650419-1-stephen@networkplumber.org>
 <20260407151732.272195-1-stephen@networkplumber.org>
 <20260407151732.272195-10-stephen@networkplumber.org>
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
> Rename variables where local variable shadows a global declaration.
> Remove unused lcore_conf parameter from sa_init().
> Replace shadowed optarg with parameter named arg.

There are more in the Arm implementation.



