Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BB9CA5FA5
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Sep 2026 14:22:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E20840DF5;
	Mon, 28 Sep 2026 16:22:02 +0200 (CEST)
Received: from fout-a1-smtp.messagingengine.com
 (fout-a1-smtp.messagingengine.com [103.168.172.144])
 by mails.dpdk.org (Postfix) with ESMTP id D1B4E40DDA
 for <dev@dpdk.org>; Mon, 28 Sep 2026 16:22:00 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id 5FDC3EC00C1;
 Mon, 28 Sep 2026 10:22:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Mon, 28 Sep 2026 10:22:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1790605320;
 x=1790691720; bh=5lEiJ8mjmy/kwzsEJ3pE39xhBjPRSyqy38/+hhMvs7s=; b=
 Xn6dEF0wT8Muhhge6Ii0uqrxFuwsKViVR9yhKk7HhEJHhhxVg2UxbXsvlyegeL4K
 SNowogq65AM1vhyJJF7hFNmQfij4orjqiMVxsLBv55hCMWN1ySGjE4XZNWTuOjMq
 l93zedgZtQalR9uKJYFzydH5W69s6cdwygJSM5ll+XZ5O0RjZDuUW5tK86pmNmdJ
 yoKh4VLxVxeed4h0T6kt2weIgwygkkUWH8mVseOpwkfb5LVnhZ7XIFPfbRQvymT3
 /Jd5M78W0Wt2LMz9CzmtE4lvLb5Y6K5CQMK1et3WXRktnR4rkD4F2X2rsmmGGYac
 Op0jadK63venmRzCewekcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790605320; x=
 1790691720; bh=5lEiJ8mjmy/kwzsEJ3pE39xhBjPRSyqy38/+hhMvs7s=; b=w
 Daoz9IccNERhWbNcWEJQmi/Cp65J3bdf9rtPsaNekD6wn++yK649Mhls2O+E+5Wu
 2g4JEcsQvFKVPUp221jqD74eFb2zPDvTFhd0GhYbCKsxj/ifIyeEv/DeIXU79OtS
 ljSltWjegqh0ykU8/zECWDzC+2xN/1+ZK/yuKSx93qcGF8iGENn5J1rkeA86iYux
 XoH1rlmBkKbnBUHli3FarBSVFWzpS06rbGnuZsLmD2h6k7lb2GnIAVi8EjNVskLI
 p0Lx2WOLTgU2vpfLYbfwYU8IL3/89AslXANgRegPdYCS4XoVIBCDRtWudiET8vNS
 raAEV6vGOrj+jbr16UDyA==
X-ME-Sender: <xms:CHi6akXVj66-91JeHUGuL4DBItGL3hxNWVC5fUkCDzrlqd8NVL7ivg>
 <xme:CHi6ak65IMD65ORRmIxgI0iCN-jp07LplTqlWIlhKxWOGqq9r7qLQ3Q5a6tn8tPT7
 7tQQ3IjNGLmR_h-h3r9cttGMVtQcolzsVSAjDPxygcra32xuGgv7HvC>
X-ME-Received: <xmr:CHi6arIDUrsOiV9633AboPdGR6grnGSbLEU18zrhKmZT_YI0Y3xORR1FUNAbSUZ4RlUNJzfh_RnWlQX49Wurytjzng>
X-ME-Proxy-Cause: dmFkZTGQ/8dG2xVrzifCKiHpf2AbqtXGbcFJ006g6eCfD0Ib/PkKB2geomOx2k4M60qZU4
 wIIukIZlxrKq0leMAXmxJqgTpAqMOMNb08ghM4UhhcCf5KOkgXqp+H+drUBzIk8AVcW+PF
 PfHRFTxo9DvxgjgQAKpl2UdIDhQ9crvchplQ1avCqhouthV8GaVRf6wzmXzjYwEM/RztZl
 rY6i7zn8/0pO6Fc0cJICN/1DlDCrwgf0UHnQnsp3lQa6vlg54AmAPFRT6WSk5jo5bReX3J
 McJgvMi7MORUypr6FzV9UKid1uJr3ellNmh5MCeb8b5FPPs2hQWSAo0ZUkPJHv8O6cfcfd
 iiUbozoyRIOCP0Yl7og93g9OgoKrB1nsVAy+XF9HySKtv0di1UEpbtXtJr2U9L4vyM8C2r
 MQJZHJFg9munQk6qvoul+Eg9BDMiSJYn11yXSI+6Hc8hPWSJJnOe9WF+eqfFoM0X2FWIyM
 1KMY8qv1absaZ1s0PN9xU2Rk3DQLkSR06aRmE4WyrYL3/C+dCu0fm5/osK8Fv6El6ybDV3
 yQRUl2s9pyvmyg8m/LKQm1loAm01ORAO18NMe+C2W4UsK/PIbQLy76NoDaRAqVf6oSSgsH
 Hj1ZOsn4SRVMDpeBf9m0bFoVBeHmRbzdmNXFilNib89sE8c9e+hkpqMyy55w
X-ME-Proxy: <xmx:CHi6alIe6Q0zQsOKN8EZmNgvuvz_VA5YF9hPjqHvQZLd4KAeJtb62A>
 <xmx:CHi6ahWLYKHDRJsq0li_byH2JU4_u2pdzy6GV2fw3WtUjO_5GmNtVg>
 <xmx:CHi6avheRgjg9JqespJCZ6FQUdYa8j0MmiEP2eeh4i4bl-81pqMRlQ>
 <xmx:CHi6ak-9r0X7EXX8rRdhJ2F1_Uv1cswj2O4IkCO5-WDgcxwUKTbxAA>
 <xmx:CHi6ajjRpJuLrGM0FUs0NMoRZOutmjY5EebzTkT0MVmi0IlTslqwZRvr>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 10:21:59 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Zhang Tengfei <zhtfdev@gmail.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] mailmap: update contributor name
Date: Mon, 28 Sep 2026 16:21:42 +0200
Message-ID: <9RwQnWvjTRWvUBMvuRMoiA@monjalon.net>
In-Reply-To: <20260927035949.36887-1-zhtfdev@gmail.com>
References: <20260927035949.36887-1-zhtfdev@gmail.com>
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

Hello,

27/09/2026 05:59, Zhang Tengfei:
> Use "Zhang Tengfei" as the primary name. Both addresses belong to me

In DPDK we try to always have the first name first.
I assume Zhang is your family name?



