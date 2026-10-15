Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A230DCC6B3A
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 11:49:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B6824064A;
	Thu, 15 Oct 2026 13:49:03 +0200 (CEST)
Received: from fout-a1-smtp.messagingengine.com
 (fout-a1-smtp.messagingengine.com [103.168.172.144])
 by mails.dpdk.org (Postfix) with ESMTP id A75914064A
 for <dev@dpdk.org>; Thu, 15 Oct 2026 13:49:01 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id 26DC1EC00BB
 for <dev@dpdk.org>; Thu, 15 Oct 2026 07:49:01 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Thu, 15 Oct 2026 07:49:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1792064941;
 x=1792151341; bh=mM8ZCVxG0NB3iAJWfVajSHZcEtWfxCW9u/n+DozLkZk=; b=
 aBcLOtUnFIaG5NVk6VTNBbe7Mu1k4RvE2goNP5MYXNOpjqqYjbu/p4oxQDE68Of+
 9QbRPUsQRv7H9tJoyB9oYsf80K6iDutX9DJNEFoD+2oLM0xeCPbMQerDCkv5Ewg/
 sVMrFwzWAX01um+etwynDRpD5+kwbuie0BbO/Gf4aAsGvUSAmuYR10nQma1sEPyH
 0cBmTT3t93hiiOkzdtFu290Y9/zkm2rqJJPX6FNJN3HQXeXmWyH0Dk5SXhDxCwtl
 zPKwSNOpC5YYRSGHNFxoQEKfB6vgwH7AeJj37TKXPdwvLwlKJEu/iiAI1WjKmbAT
 +4kOFz5oydb5CDF5roXsyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792064941; x=
 1792151341; bh=mM8ZCVxG0NB3iAJWfVajSHZcEtWfxCW9u/n+DozLkZk=; b=U
 lsRw674sDJvq3cnLsHKeEK2vK9zHz2nEygfnQA4hrf2KKYh0QjjN709j/J+o1OpA
 JFa2xUFlVAKDvfvLV5KUMASKnWs1pWvtHBcYg694DiIm2lGK3MYD4XedbdqiCASE
 +fKCGPb6+AP2dd/AW3h+oK0YEE9JjE+c/MF8OyskpI8TCmL8Y/it5SO86eGioZiD
 pmEU3/awuJLKt0s+t8t5Wsi+JrML5bmNCpuIqGNcxlKeC6NDrCrrytoHDYEPh4nJ
 qDS4XmucQVRhwNKk3K69OizmkiFdt4+sJkOYt6AIziKs37ddByvFTZb5JpVD/yj0
 WGiImqVMIDtCErhkuMxmg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792064941; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:SXO4BaHLlr3UUF10JKkfaxaLyqTLf1Ic1PxihZ0vUtNZIoA
 bIEYxg0U3n5vi0JvCnTl1fFKQHPtWMIguFiF35XpiohrZyvfdglwH6Hxs6DWhe9x
 GorMHrZiW5pJQ5zQhIYEjrpEBGBHRLiG7lkDM84xSeY0Soz49EshSKeqJX6OkdHC
 hKazGTpYCpeTpf+e/QaPHRzRmrmgHj3hdyws72OvPiyJmP+gDnPmL/1Z3zsI/rVi
 1hmNH53bpWNPiGDMcgHKWUjABAP+lzmeH5q2chTTPVGVX9nDQSe3m4plwg5BaQUE
 nrFFmTBz955+yqynQoHvTLcaS+J3k/8ykJ+xPvA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:6CgfSh4LTwHan0l24uk6TlSXHmwGM0jFUXtqyMXxhkQ=:lx01GKPic4XL2Rt8lx2RpMLCnZPteQ1KV02bDqytV4E=;
X-ME-Sender: <xms:rL3Qate0t-A-4wVPfWrm2nrdObQkRtxl7-pKg2uNMJ3ONfQTGX-DZA>
 <xme:rL3QarWqdu0lQizltKVPNwio9T3026LpmjPZN297iAPzOahXcass--Zv2viQq-QjZ
 xSdQfOjRE-E8L-dWPfQgIu0K-JPrlpnEJlZhZttwQmj6vr9oTYq4Q>
X-ME-Received: <xmr:rL3QaudWlHtoIWwmHI_rRa00MgY7K8obcMxthO_vxJ6jwkL3gdbHkky2UFIfwKSKv42ygLwpZSm3AYYYbIiHocg>
X-ME-Proxy-Cause: dmFkZTEu/ZJBRHo6nU+O3H7YTngmQnYXcPyCOAIcw4hSu+HdWqw9h+fqopuBOnjASxsW7i
 raaDOPF7scIpf12TBGwPgolQbPlXFkeVeDKPQCJYeCDY8OXfPhN7y6TLzLi2lxNmOYURzz
 MzP7UIqU0kszAG19T7LA+SL9TRGp6Lh+rJZ3jHAB/PkdJPsgNMEOEFtIkfXPyKFb8zbiHW
 38rpak4BPmTSImQwZZx6qPBdj6zz2eyhV12igulZcG9RHmRYJ9QGv+s1gyb+EPYHiuP5Vz
 OOahdqgQJuLfhoqoKfp9dSM4g6C9cevRojfqwHCgpM9kCcuOzWDDBgAtBCLKoCjqyNsut7
 /8BqUSVKf+mGDv0Nul75J4NhDls+4Mo1btxtROtvEMlP4xHbBMT1jk8wGJWA23gGx+6wCI
 bST7aQ8icfnTXE+asNPkSmjCBJDsjdchGi4aVR2fq1HDv2Ob6NaCQqdCxK4Tx86GWie0Hy
 JgZCVtKgKAYiL76I9AsbpMw2KC4rovoCTdFdAHQuq6uqcdCWWwIC0Ed2uDvvdkcrS4UL0e
 3eRbmicEk8r9IJloiBMqqOPkdvIWneViKqUyjNorIkCON/7pQvCE8dEnquvoifPl/9FTiK
 I4t8eatVQgzHYnAIXsweKtVfkCXR6nTkaI9THIg4ytPF6ZwXV+bYX403AqIw
X-ME-Proxy: <xmx:rL3QavNKX7YoLGRJ3ex-CZgl5kvpNxODJFitG5FoxvgOHeBiQIkQcQ>
 <xmx:rL3QakhJ14O6PGk0R50NrJEUGufr9NTaxV7IaZzfXtb0ETDLeY1h9A>
 <xmx:rL3Qaq3xAGYDS0SDazH65zSIo7Xs3TExGLAuWP39w0dlHi_JOj4_dQ>
 <xmx:rL3QamiKRcYRtF5rxruMlyAs-Mm-DnwkugKXAl2IBLAwJUrcECwENg>
 <xmx:rb3QajYKhAkr6ZSa2FBCtZxawWv_3Vnfqxu3lHyu05Tslnjohkgt2mBv>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 07:49:00 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: Anatoly Burakov <anatoly.burakov@intel.com>, dev@dpdk.org,
 David Marchand <david.marchand@redhat.com>
Subject: Re: [PATCH v7 00/25] Building a better rte_flow parser
Date: Thu, 15 Oct 2026 13:48:58 +0200
Message-ID: <ZmsZS2WcTr-Or_zPC6C_7w@monjalon.net>
In-Reply-To: <atC5owA-q3EEO-XC@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1787233986.git.anatoly.burakov@intel.com>
 <ABC_uunLSjatNxgGlc8CGA@monjalon.net>
 <atC5owA-q3EEO-XC@bricha3-mobl1.ger.corp.intel.com>
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

15/10/2026 13:31, Bruce Richardson:
> On Wed, Oct 14, 2026 at 10:50:19PM +0200, Thomas Monjalon wrote:
> > 13/10/2026 19:18, Bruce Richardson:
> > > Patchset applied to dpdk-next-net-intel.
> > > 
> > > As well as the arm build issue, I also fixed a number of checkpatch issues,
> > > since there were a large number on this set. Most I kept unfixed, since I
> > > felt the exceptions were reasonable, but please check what was applied in
> > > case some issue was introduced with the checkpatch changes I made on apply.
> > 
> > Unfortunately it fails compiling on my FreeBSD,
> > because of an internal API included in a header included in testpmd.
> > 
> How are you building for BSD to see this error? The next-net-intel tree
> is building fine for me on BSD, both as release and debug builds.

I don't know the difference, probably I have an old FreeBSD,
and it doesn't matter since my patch on __rte_internal
shows that the error is real and can be exposed with any Clang.


