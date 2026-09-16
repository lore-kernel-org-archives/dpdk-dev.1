Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A200BC982C9
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 15:43:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EBD8C42F3F;
	Wed, 16 Sep 2026 17:43:07 +0200 (CEST)
Received: from fhigh-a7-smtp.messagingengine.com
 (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 by mails.dpdk.org (Postfix) with ESMTP id 2D06E4028B
 for <dev@dpdk.org>; Wed, 16 Sep 2026 17:43:07 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id C2E8B1400137;
 Wed, 16 Sep 2026 11:43:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Wed, 16 Sep 2026 11:43:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1789573386;
 x=1789659786; bh=wTrtwU9hsaaeRWTctFYYMhuuo/ic+14wOV0zpoU3Drc=; b=
 kUv9X3EjERFfddwXlCOE6G/FnTzSgLXCojyn0pAq0JOEWqlqloviFu3Y8SPZffHn
 WuK8alLSK6xffvm5IoBXpdF74s9RNVmqF7C2It6UNFMvmRq+VnilChpu7zgO4c+0
 sMGybCp8O1NG64/uX5MMqploGyJnVH8iLgqUe9tFWHKCEsU3QfsHt2coCkVyAIRk
 EDYKrStKddxf1ITP2nvzwJfe5scMdf1DBMYbCz0EXDJBNRzMPMy1o+35s8axmmZ8
 EwNfsLdy51wLmVQVjdgO2pr4sXFf4aZjfsiJoCk0uU7uRSSLbluPZMe8QQrupaYx
 xTMGFikQYAyWWyzeBcVseQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789573386; x=
 1789659786; bh=wTrtwU9hsaaeRWTctFYYMhuuo/ic+14wOV0zpoU3Drc=; b=t
 gzfLDxxQY4xv45TG3e1lhtfb0C1n/3hfL/sFxdyYgq1kzs8EhvOMVx29o08fzq9M
 JNi81/HbfYDwQH28fwTh0IWLNoE2n45h82bDN6KdOsx6IKHGPQclRoD8hhzsOMM2
 ogIT+pSVAW2ZTFdNImTTUSU2svTIzci+uvTDon5AWDDbRQ/ooNBvr2OAwhVD+nKh
 1EIrcPTvmOwJjCFAUzl8QkfBTGNY1ZsQsLjVqnUGZiScfCt96ka3m2mX9ZtaAHhY
 P2cVfgeKqSgsEzE1tiX+BSw9xwACn2y0pQmjVpvSPpPwN9jaZdJitUqy+arz1RSS
 Nbr4ZRfrqCsTxJg27/m7Q==
X-ME-Sender: <xms:CrmqatAkaJUn5e0BHATvnU1Yddb6dMGYF2u0DNdyEOB-ptepCTqwKQ>
 <xme:Crmqan151T9RdPYuReSPrYHT68Zuq8TI0ayFJXLcytz80B-zlMy9GORcISVXIXT0B
 _wozee0P5oEnU-3s2wwHZyJ5s2iheTFdPx9F6_GyuMjUNxtbzaB47g>
X-ME-Received: <xmr:CrmqarURRm3m8u5RWMzOBvZIGB_KfkWmAli19XDMbZIal_Mk2WpA7_dttOr0md2hCFbXMefxkPgf_lHLj9ENYUI>
X-ME-Proxy-Cause: dmFkZTGVRtefneWplWwQxvFluEOeCq6z07QYWVNNXJ91uT/fBBkTyt4o7meGMnKrIo3PDq
 yymT8muqcQw8u3umVAXFbQcRnP1S/dDZ4JXl1bnNDmaWBWiXU5mJInM00HjlQ2/xTrbHMl
 qaP6Z6SapTxqF8aCoQoLH9aGqJU7aVZmaJnpDbpP57YU6lJkOUV/P23AfRINGCB32jBIbj
 vBFmjAvJWFQ52kLUvXThyBceocKjAoFJFxSce1hUplcDhvcnuAVNGmV84PsvBoZD3UNkpN
 FXdt2V4rRxJXgJzd51BVqENcKetjX+Oo6RlwddQvGtwL2VxXK8ycGaBKqtrEhHKgF6rpfs
 OvgiLFZeOzGJYlak/J/pQWUf5gUCLMiPvv53D3vfcKadwL4h38ODrJbk5acPbjORq0UimQ
 JQWor/IgaTpKyj04j1Th1uspI+nwDvzSJK2QHZlRK0+BpLUWsveWg+f1Bo5tsrTMxMsc3A
 nUK9dJ/zOsSTWnYIyqpDnjJ1Hy2H7X4HGZ7BUQ6iLVF7mavj+t8lyvwhUecLLfVfLnCblk
 YQk1XT6vgUbFycu1ztXM3V0wyUOek+7mvswbp/vy8bgimTj5MbrtieSUzXiFspbuELXPAu
 HfIr2HbgLY1O/U6VkTO4PEiXc0AvolrFk6zr45dANcwf3/zXOgrk+B/zdJpg
X-ME-Proxy: <xmx:CrmqapnHLZzjL5GfnumvVLJ1FwsyjpJpeWpH67NbOLHzeCpsmVo_Nw>
 <xmx:CrmqalBoJoTMHYHnUI_yplvqK3Myloat83MuQRFUsPMRd84wACPpvg>
 <xmx:CrmqaheTrHeSRZbboPtuH4FuwUNsdJJvPGgStCJbHxaJWlwGBpDcnQ>
 <xmx:CrmqaoLIm3XtvJ1QVNpGrbV2L0VvEDbPJTgx6COKbzIsujHHcRIy2w>
 <xmx:CrmqahAqKjl8d_VkalrNu2T6nGZMYLod7Suc8MsM51uM0hDmIjY7nHx7>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Sep 2026 11:43:06 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: Re: [PATCH] MAINTAINERS: remove Chao Yong
Date: Wed, 16 Sep 2026 17:43:05 +0200
Message-ID: <VYUN0KT8SeKGK6H-6PRLGg@monjalon.net>
In-Reply-To: <20260806162805.680383-1-stephen@networkplumber.org>
References: <20260806162805.680383-1-stephen@networkplumber.org>
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

06/08/2026 18:28, Stephen Hemminger:
> Mail to chaoyong@corigine.com now bounces.
> This leaves NFP devices unmaintained.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Applied



