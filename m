Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB3DC98310
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 08:36:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3431F4026F;
	Thu, 24 Sep 2026 10:36:48 +0200 (CEST)
Received: from fout-a1-smtp.messagingengine.com
 (fout-a1-smtp.messagingengine.com [103.168.172.144])
 by mails.dpdk.org (Postfix) with ESMTP id 4A313400D7
 for <dev@dpdk.org>; Thu, 24 Sep 2026 10:36:46 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id A897BEC009F;
 Thu, 24 Sep 2026 04:36:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Thu, 24 Sep 2026 04:36:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1790239005;
 x=1790325405; bh=uGxAyfiBgEcMX9ZSmKNgmwf+ltva95Jjl3f68DP1CHE=; b=
 nlP3i861hRXYHfNbI5lsIRES6LSeYcnEwN7TPzpoHOPdcPmHss09yNZNRJiuM9Ak
 ewkw7mCwr+n3YNGArbb0EJu0GRghp2RZZqn8mlVFj4TbOyTNCvvzwZA3Bqr02Zxl
 YiBGT20ASBE9b2YcOQn7VkB2JIDxauBXVeLkzNWThX/5JMWVJSi2KdihZc1bI9tN
 Aeb6VKARA3ai//hkWITigj5/wiZ/Lx39bBvjK51UTMyl4Sr5eeTQawaHHAiKefyx
 panUM1zrqsUyphli6cPr7cLD6V4H06ZjjkMi5+OthofyPDH0LRplIndIVLWZwrOW
 Yohti1urtYXo80tzM4VDBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790239005; x=
 1790325405; bh=uGxAyfiBgEcMX9ZSmKNgmwf+ltva95Jjl3f68DP1CHE=; b=P
 A6Fp/XZfPbVd13m/k3nAUhSpMPv1MtaihSD/Sa56WW8u79QY4HowTEmgbo0JCXkj
 XT790PC+YvMAKsDZy3swdAwYgAFlhlzlFO0vC9dbM83yoEQewkf2HT9snxWnYlc2
 a3VsAyefLcsKo17h/xXSYREon/0B1a6Yd+RSR9cXD4MP/HWHcrVOxpnwNFasx+zF
 D/UV1wAY4OJ/lfHjXkDEHOwuJfmY3msGPCKTiD+esb0iF8wggJId9zHn4BW/O2oI
 /FpSyzELQRe/cAFzS6uCEx9YCE9RoJersxLT9FrFdh38Nc67boNVQjv5n+mxnZiU
 wnKYcl7umpQ/z1kOaCIyA==
X-ME-Sender: <xms:HeG0amBL44Pde49vrponfaDzDPhmw7e_as9AVvpwb4yDZw8jOhpP8g>
 <xme:HeG0ar-llWg0cZcAthqBonF7w7b9_XOdnsKntsWw7JcEGKyMGi0UFbP9hhGZbse_R
 gS-I7CNffDswNvEfK42mfnreRRyWCsWw7Lqw4yv02xXCwkDQ6albu8>
X-ME-Received: <xmr:HeG0atE_oPAPtNIskiTyZGrvHQOhgPyRVjLl9qf5-IVdDWGgkcckdJMlyCNTraVVRgOQWZ5kfcGrfS94fL2xasQ>
X-ME-Proxy-Cause: dmFkZTGOArH3pF6N/Mm1HwqKAZV1Ni5AxT+F6HJURbQ5ve37UQIgNmX4f+Pq8x6+M5Y2HM
 XIczj4dcBODT04wKPA3MzgmVY8v774flZRwd5K+78aA6qPWKC+yG+8VkOjJs/hWURh8nMX
 iIoTI2WcSlRO7tQy6Kua2pNpqN3Juw2ywQd0HPuW+mikKo88gljTYk+iZuzxSd7OmmhG5V
 aPs9Oad6NtsVRlP1YOHdbWBHQE9Msgi+Fn2bmlr4j+XrgN41CNWox1uZOtee5/6flqrcWS
 jIctncpE9GbRrKjYvCKHG5EabAhPXecrzcM0+GBpG0quSFLON5p6tt7Z1fKngpY7HN0Ys0
 Bo1rspKU87XVzLcElXAVI09EbV+z7mXaJEoN+xWvZmikpzMI8UqNVF6ah11aoG8bbGXeUX
 7NHZRa4ISnLe2dGa7pXODzfqeR9jdEtQ1A2VKRTz+IBAPopUzUhyuZP332f2CtsD6Z0Bvn
 5GtNC21tWIXd4nwRo5fjQvLE6lXkgO2e34/mrkdRVuiYrd2WApNK8iMfKWXEKuJWAvK0g8
 CVdOD0PRvs06bU0Rt2KhiyW1QH9wQOCXEK+BhbNuyRE6hdNFVKXk+g4OvUYnOxF/wGYQnT
 RwvF1aCy3iPLpbm1660CyDWqnb8t7wanS1Cgc8YOV4KRsK03a3KeQQKZl51g
X-ME-Proxy: <xmx:HeG0apPYaZtYm8CCaQJEes1hp4q_ygUbXimVDBBuSqNolaNz3ELsXg>
 <xmx:HeG0anfbOwkVhV6Uug6NGN7a7k11ON1scltcj6lTl-ahJr1y6h2UTw>
 <xmx:HeG0auuF_r6LmYiO6EWq3i39_oNYKguMGepl33yIkbmjzRQ1djjyDw>
 <xmx:HeG0agnkaXL_URNpdd0f9WFo-m92wfy9_1V6IU271538ASMjonk-VQ>
 <xmx:HeG0amtwsof5xLbr3AkbxE_y4HY4Ywfp2BPe86_ajnuc2zUMgBEurszN>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 04:36:44 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Aaron Conole <aconole@redhat.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: Re: [RFC] devtools: rewrite doc vs code check in Python
Date: Thu, 24 Sep 2026 10:36:42 +0200
Message-ID: <IyiA4StYRHSdTGPuf2hfGQ@monjalon.net>
In-Reply-To: <arTSOhHVEOKr7U06@bricha3-mobl1.ger.corp.intel.com>
References: <20260923184207.626576-1-stephen@networkplumber.org>
 <20260923135430.7e16c673@phoenix.local>
 <arTSOhHVEOKr7U06@bricha3-mobl1.ger.corp.intel.com>
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

24/09/2026 09:33, Bruce Richardson:
> On Wed, Sep 23, 2026 at 01:54:30PM -0700, Stephen Hemminger wrote:
> > On Wed, 23 Sep 2026 21:19:45 +0200
> > Thomas Monjalon <thomas@monjalon.net> wrote:
> > 
> > > 23/09/2026 20:42, Stephen Hemminger:
> > > > The existing check-doc-vs-code.sh only compares rte_flow items and
> > > > actions, and only for drivers whose directory matches the ini name,
> > > > so none of the drivers under net/intel are checked.
> > > > 
> > > > Replace it and parse-flow-support.sh with a Python script covering
> > > > the whole NIC feature matrix:  
> > > [...]
> > > >  devtools/check-doc-vs-code.py          | 1132 ++++++++++++++++++++++++
> > > >  devtools/check-doc-vs-code.sh          |   84 --
> > > >  devtools/parse-flow-support.sh         |   92 --
> > > >  doc/guides/contributing/new_driver.rst |    4 +-
> > > >  doc/guides/contributing/patches.rst    |   27 +
> > > >  doc/guides/nics/features.rst           |    5 +
> > > >  8 files changed, 1169 insertions(+), 180 deletions(-)
> > > >  create mode 100755 devtools/check-doc-vs-code.py
> > > >  delete mode 100755 devtools/check-doc-vs-code.sh
> > > >  delete mode 100755 devtools/parse-flow-support.sh  
> > > 
> > > Thanks for working on it.
> > > 
> > > My concern is how easy it is to maintain for all contributors
> > > having to insert their rules and exceptions?
> > > 
> > > It is replacing less 200 lines with more than 1000 lines
> > > so it looks a lot more complex.
> > > It is probably fully generated by AI?
> > > Can we make it simpler?
> > > 
> > > 
> > 
> > The other suggestion would be to git rid of the .ini file method
> > of generating this feature matrix in doc and just have python script
> > generate it.  Prefer a single source of truth, less work
> 
> +1, I was just going to suggest that when I saw the discussion on this
> script.
> In case of autogeneration, for cases like "partial" support, we can have a
> well-defined comment tag or similar in the code to mark it.

I agree with this direction.



