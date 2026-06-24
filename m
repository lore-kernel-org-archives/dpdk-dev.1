Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7040CDB479
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 13:04:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CDEE94025E;
	Wed, 24 Jun 2026 15:04:23 +0200 (CEST)
Received: from fhigh-b2-smtp.messagingengine.com
 (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
 by mails.dpdk.org (Postfix) with ESMTP id 30E05400EF
 for <dev@dpdk.org>; Wed, 24 Jun 2026 15:04:22 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 2A3C77A012D;
 Wed, 24 Jun 2026 09:04:21 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Wed, 24 Jun 2026 09:04:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1782306261;
 x=1782392661; bh=JkxY0Lb/zWKvo7JlOtGyhn7Qkj3TD6o+xVSPvAJcQjU=; b=
 Zwl2+IxA+gTdy+Krks0PF6NYETC3+r0N/l+ohx/mvrQ+E6PId6urY72qZpsbvnDk
 qXGF1tbngcdy1/ifqQIzF97/RG6tGdtQByIOSldPYbrnszM0ZB8SghCrZA6AqDjn
 LKX5QuWBKwn8Xw1YYkQcLxgMkK5vulH3lNvGwUah/08J57EhQ9a5QSw5L+G6ogrB
 Y8aHdKXoqwg9tk1ZQLiH4o11jidRtxXinyaAV1FWnpO9vuenLbZ0H/pui1mb/GJv
 74uWsJCb/CDDDjIIufR5rxu3kmssqH6yP6K2x+wXdCdelfRVaDYtGJQv17LX9Ahh
 LrWY7G+hRf0jDX/+RZK1WQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782306261; x=
 1782392661; bh=JkxY0Lb/zWKvo7JlOtGyhn7Qkj3TD6o+xVSPvAJcQjU=; b=I
 moxvu/klzh5rdEIQDuColKbYiMEDHQbZ4caNlUDVH5m1aqslMVlp9Q6+fHzCtSGe
 CIS6qC+jC9Gpcza6NeXUNyk0eamRiYYDcfOlcPYkv49LMfxz8aeinK1kdzHvg0d9
 yhJBywqZi7HLc+16wGUMfKBiC7BmEnebFsXOCXVlTVlKYBcenX4Pjl1jCXMD0PUc
 +ff/RJXc1eS6tQSFMGtV52y7v+VUwE5++HYviEEw5pmbSAG28eb9MhufEM7yoBtV
 ukBMAc5+nAOiD44HpIukfb2QxQKASl4MX35In5M5uX0MdmicicjM8NdGzEVAq63T
 INkPUgfTMoNv/zczwIHwA==
X-ME-Sender: <xms:1NU7aoW6vusMMJponLACujD14NxwPEt7HqfixZUIXJIGNY34I9Kdkw>
 <xme:1NU7arrjzZLg924uYi3MVEtvtxa8FACdR3YouKGJoetZzPOzuEMGabXom_z7SMY4z
 2DNu_uxqDYj6Onog553P6Dwe2iq0xkULJXbi29mGlE_ywM5akBUIg>
X-ME-Received: <xmr:1NU7ainQR0trd_alNbb_wfFtjPaWRGA-DHiyana1xMoAVaBpjjkDV4QiFTtoalb1ZeqA5KgMeKgIbarEZQzlgG_-Gw>
X-ME-Proxy-Cause: dmFkZTF6s88YieMQsq8vgo9xUQpjEO9q3pRWl2RCqVOcLIJPQx3Rzfj7IPfgbQfUEwHP3c
 IXs14Z531zcFgeL8D3zC6lnqQVbDDZ1O/oo26O3elHu7N7ZwlFsbMncO5MCERAsLzTyJ8X
 UMKMGkR9hUf42k32dBpZgmeq2ljHqgUIFpIR0jn6XCe7tmDdUjhdmdT9GoitBF5gzQ56hr
 S8hmPBVO1MEmaLajXxTic4uFNPUbZcDlmJ0zMiOmV3iFWf9sE7h94f8f41rahBKJkmBMkm
 iNBUyRDqsewIWAnfYiuYFd3XupU14T7iLup38/iEw8Y43ODnuFkcXqx02yw2MKlMxjwbmI
 ferVHl6QlKg1fRicDxTj+1+DSQu5IhV2BLJ37UJDuJFz68XlWMWqdVmqkKx9w7+TYxicqH
 Y199dF4v2Z0O3fSbVunw4WOsBMmV06y5QGI0UbCxRnN5uHufrRMgnxt5gHoPXPKVqkHWhO
 +1WYqlMBA7Ui+0cbDrvP4nm3AYqk0GTjASFt6evcAJm0JCUUeKM960niVirC19Tr8wN7U0
 QbXYNKNPHPekpQcYfk73GhGI1dD+xFJ6ZjXvjXJ+aO+AuybjCfAy0WKLzuSbeF2CgvsaJ6
 ESQYtr55ZiIXuXDZX+ZuuSmz+8ERB+yHAe6+QZweOzpWi1ZfkxNeHC2bV3Ig
X-ME-Proxy: <xmx:1NU7aj2VTXtOwOw25a1E49wydXucfypxgI4aytpwgbCEGVr662AZCw>
 <xmx:1NU7anTnl9Ywy420zaLlj15BdplepnXsMQ8Oj7TQRp64YwgMyqVk4Q>
 <xmx:1NU7akzCR7C8LQs-_PEhl4ngnBhDlK2rJy76QWvxqeD1ZbH3RPqt8Q>
 <xmx:1NU7avBS8Q90_CER7QeRPN60HsTm38C_dACcn-7DXJgHdGQWql0eWw>
 <xmx:1dU7aqrm5UKLojqhnYvxbyIeFVaSxMyql34VJ8n7Z9Fe3cZFY6G5DgjJ>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jun 2026 09:04:19 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Patrick Robb <patrickrobb1997@gmail.com>
Cc: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>, luca.vizzarro@arm.com,
 dev@dpdk.org, abailey@iol.unh.edu, ahassick@iol.unh.edu, lylavoie@iol.unh.edu
Subject: Re: [PATCH v2] dts: update dts check format script and resolve errors
Date: Wed, 24 Jun 2026 15:04:17 +0200
Message-ID: <MJL-3yitSAmNqjsOXh2QHQ@monjalon.net>
In-Reply-To: <CAK6Duxs-o_OcgjM9_dm-oBFTU7zKjk1g1X0bvbS=gtgwFSd0=Q@mail.gmail.com>
References: <20260609144501.1441468-1-knimoji@iol.unh.edu>
 <20260618204525.1010218-1-knimoji@iol.unh.edu>
 <CAK6Duxs-o_OcgjM9_dm-oBFTU7zKjk1g1X0bvbS=gtgwFSd0=Q@mail.gmail.com>
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

24/06/2026 00:34, Patrick Robb:
> I remember Thomas mentioning that DTS was not checking the
> dts-check-format.sh at DPDK Summit and that confused me. Perhaps he is
> running DTS and dts-check-format.sh outside of poetry (which we have said
> is okay to do) and he is on newer versions of the formatting dependencies
> than what we currently have committed to the poetry.lock.

Yes, newer versions are failing.
But with poetry, it runs fine.


