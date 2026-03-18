Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DBB103E160
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Mar 2026 10:54:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B467B4060C;
	Wed, 18 Mar 2026 11:54:42 +0100 (CET)
Received: from fout-a6-smtp.messagingengine.com
 (fout-a6-smtp.messagingengine.com [103.168.172.149])
 by mails.dpdk.org (Postfix) with ESMTP id 7DBF84060C
 for <dev@dpdk.org>; Wed, 18 Mar 2026 11:54:41 +0100 (CET)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id E5F9AEC00C6;
 Wed, 18 Mar 2026 06:54:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Wed, 18 Mar 2026 06:54:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1773831280;
 x=1773917680; bh=dTJP7YQZpAeX0PxsvRp3cKV/i/YMzMRk8TLcunBCaU4=; b=
 FYqmwd8wV0wX4byosrWGD3e6NbXaM3IEPmvSsKpwxA9X+8rnTnAM6IzRFnUEuv3P
 S5528jskLyNWG3AnZLQn7t/oYGXVeiOE/DrIuHx6ewFywttA0N3x5+81FNDDKLq1
 SlyrQfv6OOSu4TPqFthMJc7mwbJq/M70eFnB0IATv+Ov7mRiLFgrWOTP3q9hYW7v
 TDyfhRiGR3z87Rwx4thP6F/utgtFeZyCrhSeff3Eedl/ejhsglUvk3QzBEqmiDLZ
 MLhOnWuE++6w5ro2IxQ4pqolgPDkZu3zVO5qaNZlr1lqzY9diIzo1kb7WfsGbBNo
 KfzlAYA2RnFsphipshnOTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773831280; x=
 1773917680; bh=dTJP7YQZpAeX0PxsvRp3cKV/i/YMzMRk8TLcunBCaU4=; b=0
 kVjE+myGkuPae469lD9wguFudMypQtxIUI6AVXk9eE0KW5r+V00CNaE76W9H/cci
 CavhXK2CX5wjjBfRu+aiPImTWLB56K1DKvUVRYMGZlmEA2VThE+tSAPGrXu5JO7O
 +wQQa/8hkpphDOvA7kdqPsBWMSxJ0rNFWtqE+nhcHfrpr1zvza+5aFVa4U5tUZnB
 oz6Bjsuek4qr6OadtMu+QvLb/xEMRIMVaqC8oUUoC7eAETQ4+UKUD3pguVZjLGj3
 K06X92U5RnevhPp59JsDiKCuyhtGvGmU+2OelptY9BDhS4kvHn1YDp0Sq4ROgwgD
 NNFscRDFqjvPgH41ZkNfw==
X-ME-Sender: <xms:cIS6aU3PguLEQcokOQGB8NSYQHbJ8uZ4dpFsyND7IpuaxwBb1sVmhg>
 <xme:cIS6aWhpv4pdtrj_ostmAgVGsW_BWQAB5UqVHvO2vVTBKJWu-9kfYlfJ4KaEV6i2L
 u5UQXVvpDfaomNJh_z0_g_O6H2jRAqCXOKlEvJwgONGjDq7_DIPEJo>
X-ME-Received: <xmr:cIS6aaRZkZwmHWMz2VRitHZS07aJFDOI9YeFoTUcYFLZOMkrrtIvrkzVR1hBLgIwI85yBSe0E7qE1qWMH4c2FYryDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdefleegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeekfeehfedtgedtjeehueeutdfgleefieevkeeikeelkefflefgtdev
 ieehheffudenucffohhmrghinhepughpughkrdhorhhgnecuvehluhhsthgvrhfuihiivg
 eptdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdr
 nhgvthdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
 epshhtvghphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhgpdhrtghpthhtohep
 figrnhhgrdhjuhhnlhhonhhgudesiihtvgdrtghomhdrtghnpdhrtghpthhtohepuggvvh
 esughpughkrdhorhhg
X-ME-Proxy: <xmx:cIS6aXgGZwRTKdB8gczCy1_yb55FY1CU6GVY7Pem2JdAoVMkGpy6Lw>
 <xmx:cIS6aa4Mr-Ddm9dFoitIZ3KA6iFncV0MRjva2LiVBPKlzWqS1cVIWg>
 <xmx:cIS6aUA75o5UBAHx1y-PISeJrR7_S1ZymqycVG4fwyJ0eK0XySkoNw>
 <xmx:cIS6aRbEFT6qQPM4wX63GqapiXPbhXp8kP-7DQ72pt-hjntk8bw9zQ>
 <xmx:cIS6aeuxyWHMYQ73TtjryfCSshtcqJcW0T0pe9Ss7WtqVDdZ6Zbavn-H>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Mar 2026 06:54:39 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: stephen@networkplumber.org, Junlong Wang <wang.junlong1@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [v3,
 5/5] net/zxdh: add support for GENEVE TSO and Rx outer checksum
Date: Wed, 18 Mar 2026 11:54:38 +0100
Message-ID: <3292708.fEcJ0Lxnt5@thomas>
In-Reply-To: <5668926.29KlJPOoH8@thomas>
References: <20260131062208.2445121-6-wang.junlong1@zte.com.cn>
 <20260318022159.589957-1-wang.junlong1@zte.com.cn>
 <5668926.29KlJPOoH8@thomas>
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

18/03/2026 11:16, Thomas Monjalon:
> 18/03/2026 03:21, Junlong Wang:
> > Sorry, I have a question.
> > Some time ago, I submitted this patch ([v3,5/5] net/zxdh: add support for GENEVE TSO and Rx outer checksum),
> > which was marked as accepted. However, when I fetched the latest dpd-next-net code, the for-main branch did not contain it.
> > 
> > Could you please let me know if I need to resubmit this patch?
> 
> It seems that the commit is merged but without its content:
> 	https://git.dpdk.org/dpdk/commit/?id=2aa7e28b41
> 
> It looks like a mistake during a next-net rebase.
> Stephen, please would you be able to find the original commit
> that you modified in your reflog?
> Or I could get it from the mailing list if you didn't change it too much.

I've pushed a new commit with the content of the patch:
	https://git.dpdk.org/dpdk/commit/?id=af40a93fa21



