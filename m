Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F597C9830B
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Sep 2026 19:39:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E81D4027C;
	Wed, 23 Sep 2026 21:39:13 +0200 (CEST)
Received: from fout-a1-smtp.messagingengine.com
 (fout-a1-smtp.messagingengine.com [103.168.172.144])
 by mails.dpdk.org (Postfix) with ESMTP id CF41440276
 for <dev@dpdk.org>; Wed, 23 Sep 2026 21:39:12 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id 4B065EC01EF;
 Wed, 23 Sep 2026 15:39:12 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Wed, 23 Sep 2026 15:39:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1790192352;
 x=1790278752; bh=0Sc6NNt3Rdap387ud8+Rm1Z9ayc0XzSR+nqrQ7XrwT0=; b=
 JIxEqVMQL9ZvJloWjIlhqqda8pwVSjzod1IzvlOwbeuHAH+O+bY8raveo0zr8loY
 qqVF+EhgFqFi2TQuJ4U9QFDPYePFH5XwFEUQpejFSuESspCH+D5xCG3hQKMIInAF
 B/vy/8WuDUvfUXv8EnLjd11ZtzY2uRbovAiiZAjijWfeXJ22Z+qGzdSe+mflcAhR
 I+ovRwfFBUxDQRkbl8eznFFHPVzzTalRtLxY+eSfqK/QJyLCyJvn+CCQZHM/9MEd
 6P1rRJAWUW9dwXs8eCn9HfDQ12uPUEzZRQ74gTwigBdo4BiuWGLrAfel1DHcIRkr
 Rtaan71BV2/a96Ue1htPKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790192352; x=
 1790278752; bh=0Sc6NNt3Rdap387ud8+Rm1Z9ayc0XzSR+nqrQ7XrwT0=; b=F
 9XoB54atlNNAqtUVpkOn1SABlBHiD2KJXtrqWNcbgK3mMqtuyjZWqJVwYJK+//ak
 k3FW8ZpCyRD2LWdRbQ56wPZjZYsz7ihr7TDEZO4wYxRgxgiQf1eofbfMqIi4rZGd
 jRJLbthJx35xRBBWwRCaefyhjIUXWGQ7l+TUxusx+BitLi+ZUYoN3xbTzKsWbpNc
 H8dQTxeg97jskFtrA/+AO1VdJa4LM5454twQwNEKjV9zqHHpTnafg3AaeRsiuvpo
 cBxManyA3rNpUQn8hLWwwnhDx0S+XOIsPpItxncT5EJbxVPRinJPYqvrPA/7dt0U
 6tJUlPQWQmNDuBx/ci3tA==
X-ME-Sender: <xms:3yq0alrUyDLirLeHypXJeQ7BEGgWMtQi037Sb20FVDeWv2iq5IIYXQ>
 <xme:3yq0ajexdJpzjSdHBB02o-670w0wioZy-BBMMd0LNIJuAn6rwucJL7Pm39HmI9-bY
 LS8qwqjSC3CziF7eALUphJTJ1sc3Xqedw76jPIg25cS1JVowDQTJHs>
X-ME-Received: <xmr:3yq0atkX7HOsCqIOHG3V9APA7od2w5lGD2k4IxFXSN5WiYDcu38f2bG-BhnDwt6y1lAQ7dWn9ATLsl50yz82eEs>
X-ME-Proxy-Cause: dmFkZTEzRC2Aln4waoYUhPoYHfiDft3cMCZI9ue4pqKpCMnah5rzWOCBqZxV9ZKqdj4BnE
 hvcQWOjIayfy0AZxBSuAIj/yrl1VqvMC6S5J5vyowNichsd5+wi+ZqCTzgZeWCvUKNvAEx
 3JhBV38fMAFSYJPyCULmW7DCSTONyzt9H9w5lZboJ/9S55KkgxyOD5Zz+Bniu7o5orW96L
 dgcq99FwzbM6nvE9ibvlu6f2SM1zCdW4ZaH9xgCztv1Kc9s9eakNOD9q4CDdcrIBhO3nFY
 wqSj+K5nQJtmNsu4LT5wmvyb2I3JiAupY2l2aFprBqfTvfYa7JdqxhkYBqnKb0LH9dsnBX
 yVcdXtPb4yoAXczl2UmR7l5pLP1FUpMqaGrKRHj2JHplhGFLN2pEPvD7IywB0QFk85Kckw
 nYKPcbGp6ezYuG+jGFGBq09NYPLtNaKDtZlkeu0zm1Zcpg2y0AF40y7dPn3ujGdikGjwAM
 FCHMLutI2/0KE2daLb9cHFw85NKz3YJNgx6abFoiN8UomirB1aHx8ZJJM1Ky1AasAA5vql
 3qhfGdpoMsC1nWHwM+Ys5w7+Wz1EcTjBqGi27e1Uf4tHxIfUS5ONbagov+YKzkGahtCnLH
 xitvlMj12BiXD7pHbRrpdIN1Q+DDbYa6ixaTrT43NwNXK8yJvsj/KYsqXvPg
X-ME-Proxy: <xmx:3yq0aqZardV68Eusw-SAQ-vit93c2kFNFmUCmDzUXVUjT-3J2rQnQA>
 <xmx:3yq0ai5T04XF2xggKWhEDyQ70MGGebYsaNyXwm70kHcAM65CWkCI2g>
 <xmx:3yq0akCQHJX42P7O0sXJHuvGeP3jNjTBz7fndDjyDqvdj6O56O3A3w>
 <xmx:3yq0ag_5W2uuOg56LN0EW7zuBRK1jExoUKzqh2KxWG84OKsOUC8dHA>
 <xmx:4Cq0ak5qivD6a1XPSeI8vZCSi5c9QCnA93n3D29GoUZurYY4e-Z1qmR1>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Sep 2026 15:39:09 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Scott Mitchell <scott.k.mitch1@gmail.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Jack Bond-Preston <jack.bond-preston@foss.arm.com>,
 Jay Wang <jay.wang2@arm.com>, Doug Foster <doug.foster@arm.com>,
 Chengwen Feng <fengchengwen@huawei.com>,
 David Marchand <david.marchand@redhat.com>
Subject: Re: [PATCH v3 0/5] eal: RTE_PTR_ADD and fix unaligned types
Date: Wed, 23 Sep 2026 21:39:08 +0200
Message-ID: <9_SWtqM-TYKCyZNk6xgxdQ@monjalon.net>
In-Reply-To: <20260907183239.629053-1-stephen@networkplumber.org>
References: <20260904220953.3105930-1-stephen@networkplumber.org>
 <20260907183239.629053-1-stephen@networkplumber.org>
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

This series requires some reviews please,
especially for Arm, mlx5 and EAL parts.


> Scott Mitchell (1):
>   eal: RTE_PTR_ADD/SUB API improvements
> 
> Stephen Hemminger (4):
>   test: fix jhash 32 bit key type
>   eal: make unaligned really unaligned
>   net/mlx5: drop unnecessary STRICT_ALIGN
>   arm: remove no longer used RTE_ARCH_STRICT_ALIGN



