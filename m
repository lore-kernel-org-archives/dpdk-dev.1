Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F02E606A325
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Nov 2026 00:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=v2KkQBQy;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Oy1TrBQx
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E415A402DA;
	Thu, 19 Nov 2026 01:30:23 +0100 (CET)
Received: from fout-a2-smtp.messagingengine.com
 (fout-a2-smtp.messagingengine.com [103.168.172.145])
 by mails.dpdk.org (Postfix) with ESMTPS id 619114029D
 for <dev@dpdk.org>; Thu, 19 Nov 2026 01:30:22 +0100 (CET)
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfout.phl.internal (Postfix) with ESMTP id 5AA60EC018C
 for <dev@dpdk.org>; Wed, 18 Nov 2026 19:30:21 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-11.internal (MEProxy); Wed, 18 Nov 2026 19:30:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1795048221;
 x=1795134621; bh=u7DeDQD/595XIPj2tX9WqdiEKy2IZDsiUO+S4d5sF/0=; b=
 v2KkQBQyU1gpI7zjflwiOjYH6Vr6Yb8dnDmG1uDvyTUB2Pv5WLDG7kQJ1qAWUs1P
 gACjDXl/QYm3t7V237qj4aEnIOUXUdsxvM/kxzm3RVogpWl+qX4cUTK2Gl+ZSbhW
 BKvh/1IKRVHyJJCYIHvsOe9LzGB8Hpb97IIvU2DoRhzRpisb3+72k7drp61qAeSk
 6p4ZdJs+DftAPBcOJqb/RM2Z1B39tZkIeQCLJvxkZgqu+M3wu+TVsgzLxAoysU3g
 Wa7YIRCKne9xDmdAfeahmUZLqA7U9t9c3+fHUgutHEF+jNiJC5nbS6V4Tv1O4yvo
 fvouGed4YfQd+GKJ1EjVkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795048221; x=
 1795134621; bh=u7DeDQD/595XIPj2tX9WqdiEKy2IZDsiUO+S4d5sF/0=; b=O
 y1TrBQxZ9LAxFnK8MMzrQI/ukdS7XWE6f/AIFduJwmwJI6XXWAsTDno31SjQ8TEB
 hE3PZF3kqh7wYM3wklnPXWX6DS0J0WRmY1ELYDDSniBaWpRqfmAqpjOJPGCr6QgE
 Db0NGlK+KnT/osJW3T/9fvbHrLXzqyoOGPimoa4yYPtjb9+u6/yoDAAVoq/2sPlo
 XEotUHxbDA2tAb3XssXpO0LlO0ef8qrvo+WESrdBUo5oO6BUIlw3NvbBoSnqe8AZ
 vWxC1H5qvQSWs7l2cuJRbPQN7w3cQO9KaBS5ETRn9aP6I4X4ncZGLYx2lb1umXGm
 I0NrhU/OsUTVEowKaWxNg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795048221; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:IP+AZAr7bi52IgSMLp2mhWIPPC/oGFk/jMMfflLURp547ah
 2PsHoNXu4X7QdnB0Y3RYxfmtj2ECK/Mb7tWgxyhGq3mvAzs1NYl3x6cV7qQUQLKi
 WpQXYLGGlsWQP3XWbB1V0AlQzmpqIT+uj2a0mNDq0A7eLFSrwBeY5+6s1PbZau2v
 SwEpmMUL2UWwdPJzS85mSAuFCs/+MeEW6F3SDGzJ+PbKp3U3Tp4aXay+h/gCTKCi
 +6BLqZNfOt84jMLQuejjYciUm/LKSAgMLEwl9OzZYxs638TDMvLAmratdspV6+Me
 sty1nfy/0UV9BCVnWIkZHEHhZrp+AtLDjgZ+Z2Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:NxPloU5WyJ7zPTly8mPTLr/HgIU5ayiVaYzKVzffgdo=:EP+omT6X6Pb7xtoP6nRGbT0H8C7pfUL0OQr4JMOyYQQ=;
X-ME-Sender: <xms:HEP-aqY4RXRxK-Bv2OhZ7dXZ8Arzn5XJfOVg7qjNV-cyqRayZW-8jg>
 <xme:HEP-auXAnhvOffMo7jGkrTqrzOxQx1uuqdcLoiC-yzQZmqnRliRWe3131MC-QnF_d
 cbs_AdZ3zwj_zzLXj6kud2m5opoqZrfoCGy9EBkshn-ufuGAsLk02I>
X-ME-Received: <xmr:HEP-alTlrqsR5EcVeFKF2RT7xXWn1uvwgOrAXAlbC4vv7KkVTrcaz-ubJ6Bvv2GnjvJzs_zA5SIFX8qpFaXm4YA>
X-ME-Proxy-Cause: dmFkZTEznuB6rCDq4VEfHGgdK8MYQCjA0W/tjQgMWcC2EpL/oc7CePoxcfhxUoo28NWFtF
 Lj6LGkXybhFSooLt/vRZ97/ZU4qnIwDQTLyn7+eiYBm2tMq4bSkTMEKr38jC5WcZJDUXqp
 aWAGho7XV5dGQ6+cCsV2PvlU6eNpFrKmUzBz4LsKOB39cw5CAiGeeG342e5LvgF5I4FR6R
 EQo5MXiZJ91OL0n8vXnaJ87lK5OzFaFwLsqNEkj/28igaTX5KuPJjkQpQEA83AwJoP6MA5
 cbZNIwBC79s270+STiLAghlQfN/tG6yKU0dXdtS6cvgrvcZ8lLhg+Dq7ja0iGs+lDZX3eQ
 wipPiwaj/b9Dt1GxHsb9S0Cyl44zE0/t/aSMU6K1fXjzfHzBweGGJiZZELRSbUJPq6iAKn
 jgT4z2qERlOubskqXCqupNSX1DwyK0bNx+q6LhgHKn6E26zLSTSMDZq0CdwuCHWXsComfV
 2sNFeYjf8cP9LinHydrWuQVFhDydY/XQRxC/DlxywUmIFt4lgvs8eVEJcjWHbH5d7k6q/c
 VXCxMfvobULRml+xJwi6ihnyHNXrTbO3yvgd14lPM9fHHvGYxuoxEuBCfAyx0OCbYl5TKE
 c841vbHsRogWpVnzXPaQ4Uf/YA/elq011TrAb+sHSVMJQrVxijufJv35Vo7g
X-ME-Proxy: <xmx:HEP-arHmcirOtewCgQH601EQog2kdjqjZBq5DafHtqxX3AM9mzbI-w>
 <xmx:HEP-asfhUDEPP7cUR86lX975yFkrGyPYODD3UmDM7XZgJGrzpavJ2g>
 <xmx:HEP-aqKqAalnSfoIfITWEtkcUL2Kv9uVGXx1SHwon29qWeN-Gzrzgg>
 <xmx:HEP-ajrPPAFYsU6ZpZMorLa9CJucs7VE2iyX2_D2R0km7LzM6tli-A>
 <xmx:HUP-amfn6WrRECMkKD0LwFIbb6YqEHbqRFVArvNbZ7lo3q5Sut4XpiEf>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 19:30:17 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Reshma Pattan <reshma.pattan@intel.com>,
 Aman Singh <aman.deep.singh@intel.com>,
 Naga Harish K S V <s.v.naga.harish.k@intel.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jakub Grajciar <jgrajcia@cisco.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH v5] ethdev: add buffer size parameter to
 rte_eth_dev_get_name_by_port()
Date: Thu, 19 Nov 2026 01:30:15 +0100
Message-ID: <9EzA-lUmTGW-JmFduPnSYg@monjalon.net>
In-Reply-To: <20261116103711.45e7d6e5@phoenix.local>
References: <20260409013658.965613-1-stephen@networkplumber.org>
 <20261115213640.1037602-1-stephen@networkplumber.org>
 <20261116103711.45e7d6e5@phoenix.local>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

16/11/2026 19:37, Stephen Hemminger:
> On Sun, 15 Nov 2026 13:36:21 -0800
> Stephen Hemminger <stephen@networkplumber.org> wrote:
> 
> > rte_eth_dev_get_name_by_port() uses strcpy() into a caller-provided
> > buffer with no bounds checking. A mistaken caller that supplies a
> > buffer smaller than RTE_ETH_NAME_MAX_LEN can overflow the buffer.
> > 
> > Add a size parameter and replace strcpy() with strlcpy(), returning
> > -ERANGE if the name is truncated. The copy is now performed under
> > the ethdev shared data lock so that the name cannot be mutated by
> > another process between reading and copying.
> > 
> > Update all in-tree callers to pass the size of the buffer
> > and add checks for return value.
> > 
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > ---
> 
> I think this should go into 26.11 just because it is easier to do
> API change in LTS version rather than having to do function versioning.
> If not will resend with function versioning for 27.03

This patch should have been merged earlier but was missed in next-net.
After verification, it looks safe.
Applied as an exception in -rc4, thanks.


