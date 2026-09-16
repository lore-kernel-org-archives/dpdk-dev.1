Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF690C982C9
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 15:45:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0948642F03;
	Wed, 16 Sep 2026 17:45:11 +0200 (CEST)
Received: from fout-a4-smtp.messagingengine.com
 (fout-a4-smtp.messagingengine.com [103.168.172.147])
 by mails.dpdk.org (Postfix) with ESMTP id F255C4028B
 for <dev@dpdk.org>; Wed, 16 Sep 2026 17:45:08 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id 9C2A1EC0594;
 Wed, 16 Sep 2026 11:45:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Wed, 16 Sep 2026 11:45:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1789573508;
 x=1789659908; bh=QqGd20JxdUniKV3+bxPGEp3UV52uTdpf+OEFapa65/Y=; b=
 ghhbIQ3csZqr0YPmTn2+kwep8zp/2TkLis1hp468ikHXuRuXEHRvWr5lG5NHtoJz
 3jE/XSVvStHZRr7fSq3Phbq8IFKSmuRItWtjkLDBIZ/S7qsPoHv7shQAG5VXIcll
 +c6kHrTD3pCT1svJohxEP6V85Q+co6nod0enwzn48d7u+LOuunPvBKxItB5g/qqE
 nEslX8ynolxpRvPdh1hTQuBigEykNDYK2fKDwqcG9ZdzG/tZN6pjOnA2S4QiE15H
 v/3Y3D7HgI5ATlRMpoB28uZJ+/a3J2MK9FtEyUAAPMZXzOs2vNgy/HQG3q8y0kjt
 24+13ozknPC3EQb6Scak5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789573508; x=
 1789659908; bh=QqGd20JxdUniKV3+bxPGEp3UV52uTdpf+OEFapa65/Y=; b=N
 Vokf/5Bs5jFwU6qHEbBK80tYp2OVy0ZVXHOlcV0GpELLtEpGI7mYprQuyal3gY9s
 zKXr3Pqct3/86ewPGIhzWmJqQYOLbBKFRSiCDkkCr9up0ONcbT4E43c/M0hs9eSM
 PMZfjSyakejkd55sZixLOG8wRo6wMYl/zniQtA2e+1nLPVrknjfM+T20nObzhwba
 YJAkR9iXYu1NrRRoVVgOJ61x8ZuCWnXDsopVtjK14RUK/lQmCwyJWcgeSvOM0LpN
 zkVSc5tWocUj4vLzwANkNV7HWR7vzjBX3v6Z9qKT1NEjGByg3P2wSuiXnLbhsOOt
 5DR0kWg2bf2G27WO3VZtQ==
X-ME-Sender: <xms:g7mqamelsS03MXQSkf4YGOZlRJ_l7MRZ5N-_M7nmYN_AwRMlR2bVag>
 <xme:g7mqarpEyCp3xKVYIRFBFPnY0XJLt9RoSGEPo2wPtRrIYDad63RtNVtFc2tLZjkZT
 cROmgETm0L1yjPebyqd6zuRG7vz7rOmeN2q2CqD8VE52r8Vx03Q_II>
X-ME-Received: <xmr:g7mqarByZ1Qgqio-f86OexC2drWlJUsB86KZQ-ONyMsEcVNERCW6hQH_tkHMTdhYGbbvr_Zc19F77dG9J7PWoCc>
X-ME-Proxy-Cause: dmFkZTFFtG8ndmKwT+ikgqIrlLMijC3f+nAs/TlunyfczAms3rnxmD44DFGzi7QfG4e5cm
 M9xkToaAeg/xNEsw15K5/gsIhYhQ4zYN+luhRUT+T5P2mtfvmBSZmPfxU1mT8UBLfo2w/+
 zka24QhdDSd6trmzh0P6og1KXqAfhHOxMVOkOw6gPhGSsYgIEpVURWqE3tf3aLuVspxb8T
 /ZcU+BX1hBOV6UQH+6hDbgnJSrE1Nw6UqFMBNJqzPIvGi08ahqCH5SAWdKPsCks45W+xGS
 KYXB7RFgJWIfh4n1XtvyiWk0DHlRInwsPE7ZvNIbiIHJyK5lZJ9c7kJiAN/xzF8NttvOq7
 4lWTAcQeP7rvAlSZoYJLJjenBQ2YAFKmCdZ+L+trVM0FBDGtIVM6C7dKpQadLisUMAigKL
 XIBz8K/8P2lxMvUvsjtNPdfcyFGonBbUfXDejnTW9pUAKXv3E+llhFo9DZQEqjOUpaRBnR
 O4rhXv89pSjj/GIi7L5FLqdGMeNPiHa7m7P3EGQWBiZF12KdqUjn1ZqXwIiTzLJv6Mtg5p
 EwuytP6W7T6nWapZyp1Vc2bFD8DGlmrNR/uZucE6gYGrOPp9yj67QiWC+tNWRDk7qQoTWz
 wAv+GQWOYx48voN8TFGWz5wd6WPAD+AzeEvWVAwODwmplK9JmKlkToZp3Mlw
X-ME-Proxy: <xmx:g7mqaobbglY0e1Ho995CwtmrnmuiIdXWAYzhvebx9GN8xqVroWvTww>
 <xmx:g7mqau5ujJ33t3KZrWZ7MxnkYKaA8wJh5v9OBRPQV76Mo5NyTOnbfw>
 <xmx:g7mqapY5fm1x-h1EtJZcE8L7G2EXzPcA2ksvcbpT2mcSj_GNuge6Vw>
 <xmx:g7mqatgF2WXAjbn-VWSjXDwFxWGWmL0WPKdGcG-DHTXYvgv1_lVBbA>
 <xmx:hLmqajxaIJJoGjId0UDNy7GUe5kUXyRPXXi-Gp2s-s-eRzLL9WVlU5jW>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Sep 2026 11:45:07 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: dev@dpdk.org,
 "konstantin.v.ananyev@yandex.ru" <konstantin.v.ananyev@yandex.ru>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>, qm2k21@gmail.com
Subject: Re: [PATCH] maintainers: update for BPF library
Date: Wed, 16 Sep 2026 17:45:05 +0200
Message-ID: <s9_SFl7uT76yxANKAH1hDg@monjalon.net>
In-Reply-To: <0b03434848f148c4ab471a57acf75bc5@huawei.com>
References: <20260916100203.65373-1-marat.khalili@huawei.com>
 <0b03434848f148c4ab471a57acf75bc5@huawei.com>
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

16/09/2026 14:48, Konstantin Ananyev:
> 
> > Marat Khalili will now make contributions to the BPF library
> > as an individual in his personal capacity.
> > So, updating his email in the MAINTAINERS file
> > to be his personal email.
> > 
> > Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
> Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

Applied, understood.



