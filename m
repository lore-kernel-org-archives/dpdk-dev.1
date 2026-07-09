Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFA8C43458
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Jul 2026 12:03:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AEC7B40655;
	Thu,  9 Jul 2026 14:03:35 +0200 (CEST)
Received: from fhigh-b3-smtp.messagingengine.com
 (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
 by mails.dpdk.org (Postfix) with ESMTP id 90165402EA;
 Thu,  9 Jul 2026 14:03:34 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id BF3FC7A008E;
 Thu,  9 Jul 2026 08:03:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Thu, 09 Jul 2026 08:03:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1783598613;
 x=1783685013; bh=SuoyrYgbLvor+Hw9qbmHJLfb1X1z03w1Oc5JkwY6vu8=; b=
 a2jkaQ68FoWvINxygE6cklgKtBHVAeFNWYb0nPHi3hi38UD9q4S23AAYaWJa0KZ0
 udxUc75rsggeMMMSkRPmDZs5//oEIRqAf0p1fKL+3udrSNurvDU37tXFjsNBeXQE
 CiOQM6bC1W5qRgz/jtT04MB+CNYeJlzO1MQLcmMUuyX8goePmk+eg7h/vv8kcf4n
 hOl+xYWmkXojbeaLswJcfkt4VAiqxOz4iBCv/B+4APRNjupT90tpQz7UlIlCgE7E
 HHgLcbq7BqNi+Xe7X67R9N/ltlGyADmCeuia1MUGQTvh2c9l9uJ7txPVo+m0A5HW
 jkD4bysWq7TrR31TbNaHPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783598613; x=
 1783685013; bh=SuoyrYgbLvor+Hw9qbmHJLfb1X1z03w1Oc5JkwY6vu8=; b=o
 uiBfQ75yMUC38CihWEIJ4Es04VPbgpl5WApWKi2twSqcR51dbZ7vXD9CLip+txcn
 ggW0frqkthqpQQ1HEpq/wpuLwBagbRVRhxDuufbQK9tuMRdf4wHBYQjyvEQxTgF0
 BqH5h2lQnxLCZ6+xVC0VkQXXBBSLZWz9gX24aHfTIwrqGcOPvV6lt2h9SVuIWmXj
 pYVzbLphohh/4mQLAHroArFcdzgMOcB/oY8bJbJHrptc44G198NB2y5FuQmVP7aq
 Up4OMJXZHU7uiDq5h3cCyowz1Xf2oX8EBfkZG46kiXPZJ9FeLaneSlV4UKMYOg0b
 rPk8jBjTzdoHK3RMMeVkQ==
X-ME-Sender: <xms:FY5PaghdFlkbORNlP0RLtFfhNEr9dPIsW45RhOIb696twe8NU3fZkQ>
 <xme:FY5Pah8md71klGXznyXbHCDxx-VwQQKc31ShoWRbQWAit3gZ_DJjPwfYZiBsHHPFn
 WqMm3aFkn4XY_560tmwjRtg2_Ufm-m0FDO4hQ1uTL8QfblXkSLO2w>
X-ME-Received: <xmr:FY5PajpdyBRi6GXQe7ck3_23jZV9UrreVmlsAmYc1nqqbvG1V3lxN7pId6OXoR4auMSRxuGGX8MEhUW7KBj0-Q3suA>
X-ME-Proxy-Cause: dmFkZTGqY2JKxwNHxZ/rREH18Q+5HG37syGnWORzjJfPKjmNVlujhZ6A8e/fmhMy/GYctb
 jh2otZtJhiOIS2L7bRmQXBals1YklK8apVnA2PTqm8/5/gUa7/I/H7gwiAuNnYhawU/XeQ
 aL5T3NCj9sWObVlb3IkJ+8g3QKFBDuXRsflS/e5ntdM5kUJ1/u9BGCJKta7NbSynjAkxQ/
 GPduC0yAGcKzIYiCkDvHIru2dTYb24jFZcYhv8wfvZI3nIQAkwxiRiHxRY3gdfynuTedMZ
 yQnszYefxU5YjQzM+vCdtGTcouTJZtqUMHojYuPrOAfKq/K/c9wkakF6cECsrIePzIJfZM
 h9dyuzWvn1kEMN7b6+PQndxzMt2ADbgmmW1ZVBuuVo65QMc8/kDy6ol1GHGKlU/INxg3cB
 l2hR27AyQksElNdf/HT41NVoHFS5Jn0epxmMEx+S2ogbRUht47uOCTlrYQNlecu2CnosYm
 FhJr1TnuRTLhIZLgXaM6oH15AStpxUt/e1x25+EMqqYnK8CkLu3WbPOYbEIWHUY/6BG+b7
 S5nWOYF3hxPcUmI/nZdLPaeRsUNHXVTtYsNW6+1qhnCdfg33bqL9QsS+mER+qLcJ2Prhyh
 jx6x/INlhcVDfp/c+e6JmwbPjgVO+7GJSn+eicOQnNDinG1eNzpFIaYqECjQ
X-ME-Proxy: <xmx:FY5PahUP-xEdohf7iFQRFa17uX9bk7-g8DXlErm7dRlTJ-is8JrZBw>
 <xmx:FY5PaqCkkZ0g2fdS-61wMXInans7UbNsMHGS6b0wSEdWjYVEXCoKpQ>
 <xmx:FY5Pat1HWFipShIbfaZuERRLlVZQwIZOIwVpwJcTtWXkDxCsK5RoJw>
 <xmx:FY5Pak32WDoQds_ScDkY-EVxGJydFzjWJBBEYiyhEYaRcFDymhJzhg>
 <xmx:FY5Pam326nbXhBfLluQaovybQOAb8_5zLubNqgRGX_1Du1eeScWCUFD4>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jul 2026 08:03:32 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: "Hyong Youb Kim (hyonkim)" <hyonkim@cisco.com>
Cc: Alexey Simakov <bigalex934@gmail.com>,
 "John Daley (johndale)" <johndale@cisco.com>,
 "Nelson Escobar (neescoba)" <neescoba@cisco.com>,
 "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: Re: [PATCH] net/enic: fix potential null dereference in flow mask
 check
Date: Thu, 09 Jul 2026 14:03:30 +0200
Message-ID: <Vh3QFBc2TJCkSwMa9Ds4OA@monjalon.net>
In-Reply-To: <IA3PR11MB8987402CDECFACC6831119E7BFFE2@IA3PR11MB8987.namprd11.prod.outlook.com>
References: <20260707085831.40355-1-bigalex934@gmail.com>
 <IA3PR11MB8987402CDECFACC6831119E7BFFE2@IA3PR11MB8987.namprd11.prod.outlook.com>
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

09/07/2026 11:57, Hyong Youb Kim (hyonkim):
> From: Alexey Simakov <bigalex934@gmail.com>
> > --- a/.mailmap
> > +++ b/.mailmap
> > @@ -71,6 +71,7 @@ Alexander Skorichenko <askorichenko@netgate.com>
> >  Alexander Solganik <solganik@gmail.com>
> >  Alexander V Gutkin <alexander.v.gutkin@intel.com>
> >  Alexandre Ferrieux <alexandre.ferrieux@orange.com>
> > +Alexey Simakov <bigalex934@gmail.com>
> >  Alexey Kardashevskiy <aik@ozlabs.ru>
> >  Alfredo Cardigliano <cardigliano@ntop.org>
> >  Ali Alnubani <alialnu@nvidia.com> <alialnu@mellanox.com>
> 
> Can you remove .mailmap diff?

Why are you asking that?
Any new contributor must be in this file.
If it is not done, I add it manually in the commit.


