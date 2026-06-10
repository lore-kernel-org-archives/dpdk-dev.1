Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB99CD8CB9
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Jun 2026 14:15:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BAFDC40671;
	Wed, 10 Jun 2026 16:15:56 +0200 (CEST)
Received: from fout-a2-smtp.messagingengine.com
 (fout-a2-smtp.messagingengine.com [103.168.172.145])
 by mails.dpdk.org (Postfix) with ESMTP id 8AC954026D;
 Wed, 10 Jun 2026 16:15:54 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id 12E4EEC0238;
 Wed, 10 Jun 2026 10:15:54 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Wed, 10 Jun 2026 10:15:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1781100954;
 x=1781187354; bh=j5pMoLe9WqSqJfbqgx8HiioQDZ7SBsumAu1NzgJwnqU=; b=
 UuMYZIXL3IyBXq0Zr7mArqONUOC0Qou6Kw2OtLOje7xuswkCaCGTj3sR3rp7MqeW
 VkXsT8Q8m5EtW4CkX3nnOfzL9V1MQjfIXla9zUGYgWckAKpz2A1/qBjT4Ao9KsaC
 bzyBfA2JzsUSKKk9ds7LpqdNz0u76vbZF3Ap0xsucFPubpYo+y9MmWkUh+nVOF3y
 yY4kA6d3u+Ucdwp7ejqH8d5zdYr1OiuDDMY9Ttba4V/rPc00cY4mRdgx5rq8AjMx
 yBa/18QLxHsarTcBlZYA6Au7QDLaLjzkVnrYxEfvAgASzt7N4lIGR8auHI/oiFDm
 uWUAvu76Zxh1DTsqUVP8/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781100954; x=
 1781187354; bh=j5pMoLe9WqSqJfbqgx8HiioQDZ7SBsumAu1NzgJwnqU=; b=E
 HJ9GcnGpWaWCEspVxwkXhX2FwjGnSE7JfxrM1REh1DYP1FSxOXAasK9Q+2oONmiA
 yywN0sjezZwQTCBIDyqojlzoaj+YHZFgtBEwsUSGt1vut2PYkecB8Cewm2Vyoi+O
 M5S+peuqKS+SiDJ96tZQb5H5TGXg3dqQVICBKulcOS/9wFH7zdIV6XNlG94cHyL9
 bP2hpPEMfo74r6BDRv/ugQJv/E0jo07nU6sWwDAezhzjNGCNPDQ6Y0eF9YF7Sb/w
 OGMySCIDbRmyHqF304m3dZusrvQRvHqioIebGv6kK2m27/3RxhPOpLlIerEiSE7u
 pNDLEQQE5ddMQ58UiqzXw==
X-ME-Sender: <xms:mXEpaqGn-RLvdL7IDKmlxwibcrwaQvyU5_DcCA-04l3SGDLmFCj4Lg>
 <xme:mXEpalZloNnQGQnCXb1ApwGgcsBs8NtPJbrN9wm87MbkhswpE91FvNaYhlwBDJADW
 hp_99W5UyRj8TIbcHOhFHkFajcpu0wyhz6uaw0D_OMf2Z0nqWht_A>
X-ME-Received: <xmr:mXEpakDFeDfzyOV0RpADfIJGT51GJFOMgsUUuds2YUIdVlgf-8jC2VDKTOj4dQdxw3E5aoZuV_lMVkdWBEjfd6coIw>
X-ME-Proxy-Cause: dmFkZTGA5J/oo+utKV8sorNbl6a4GaRdDBGCRygoJNc0XDf2IX7pG71AP5Nqg75IgUF9GM
 n0Gkw+80GF6RKmYhAxenPsmujYLRh1AWPNdTBiR4H/inRrDkyPQrRw3oLqjG7IILrA8I/b
 Y80YTNL3ipXrP17i6p/10Jjq5uJDzVsit+eNDX+f4XVSbGBwqMSM01yAn1uVoUlDcz4Az9
 HGECSUNogEPWsHEPxVFf308/onTcH1F5qQsTljNuvzmKFndLEDQtqI2pc1nLH86i8XXsx5
 6sun56hMzQV+CGrV8lmtBkKuFDdGXP1wtk9AHKgFs8UH/A11rWbm6Q3cf129vjAap/Grge
 1uIK2P8J9d0B1aWt9shF7IN82Hx9S5APPzvBvYHSJeMsDewEZOEqBrTde442KZUmYjeA9N
 cB2tKk/LvrcF96F3UlNmjdFK6J6D2/VoyyPbS+icGKTr9tPmCKEr9JKGjKxfBfeX14qQ2k
 I5xs7SvWVL5F2BBz5rglmCX0rwZ3MBy2m48Sgv/5E+l9jJHYfMV5swuvdFES5un+tZNfKy
 4nI0cfkMgifQpuKxuV6YfhWfVOTql0cZCj0QkwumoR5SkxX95JbPL3NA5e20QxJ7w/o5pf
 tJSTwGm4o7YGMZuwF/0SNYIs0rHeDbJyyvynVHNoWowinKmBlfqKihKzJsfg
X-ME-Proxy: <xmx:mXEpall3DAV9ienlFrTb1Se01KyJN4CATEZ0wOJuPw1V0JwBsT6cPQ>
 <xmx:mXEpatyEISGoEKwpIbxg95la0F962bt7idOn3nkCb1Xeih2KYMY03w>
 <xmx:mXEpanRXXPD3jvwPKEJC-rHz-KSi60UHTSqy5tm_VERYZdiMI-jYOQ>
 <xmx:mXEpat8CEq3-Nv3aLbcsQ_VHFoNC9Y_inHw-Uha9eAzdzzZr7ZR08g>
 <xmx:mnEparUmteGa61MXJZOC2LoF66p3QMhaS-opsZajo4uyp8-WjSSILYxY>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 10:15:52 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Weijun Pan <wpan3636@gmail.com>, Hemant Agrawal <hemant.agrawal@nxp.com>, 
 Weijun Pan <wpan36@wisc.edu>
Cc: dev@dpdk.org, Sachin Saxena <sachin.saxena@nxp.com>,
 Jun Yang <jun.yang@nxp.com>, stable@dpdk.org,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH] bus/fslmc: fix shadowed variables in queue storage macros
Date: Wed, 10 Jun 2026 16:15:51 +0200
Message-ID: <2S2V_VmSTBa7oGRJ0YAQqg@monjalon.net>
In-Reply-To: <20260407070940.225de771@phoenix.local>
References: <20260404171912.48947-1-wpan36@wisc.edu>
 <20260407070940.225de771@phoenix.local>
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

07/04/2026 16:09, Stephen Hemminger:
> Why are these not inline functions.
> Macros with lower case names are likely place fore confusion like this?

Hemant, Sachin, Weijun, please could you consider this comment?


