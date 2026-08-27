Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5379C61DC2
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 08:03:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D1B7640150;
	Thu, 27 Aug 2026 10:03:04 +0200 (CEST)
Received: from fhigh-b7-smtp.messagingengine.com
 (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
 by mails.dpdk.org (Postfix) with ESMTP id B0B654003C
 for <dev@dpdk.org>; Thu, 27 Aug 2026 10:03:03 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 0134F7A00EF;
 Thu, 27 Aug 2026 04:03:02 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Thu, 27 Aug 2026 04:03:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1787817782;
 x=1787904182; bh=QpUNZB+0iR5Zn34gPuviCPOosJmixfmuVU3jGsigAI4=; b=
 OqBW0EoI4Y7tnsyoH8vK9ktxBrvH0lzFKkr13Igg0W0L1M/7QOiVqoXgTMPaM1Fa
 2GI4wrWWzhr3pRsoNxWkCgyIPUKoXT/n7u3QS4Ojv2ikB1CFoFvacevmA9Clu7fu
 sNIurRLLIILagu0Sf3FE5xTBfAeoiAQ5cGUFKBppvK8D5m5a1KBjKPxD2q/Tic5M
 +Dbub+Z8bl8raw8QvepV2Pyh4GitFbx4el7/eEGS1y5iuEKOCOKbV2fe1fi44rzA
 dQwPIyPaMipchpJmt2aD2rQo3VCSQI6iJfIpWJkIkWZnly9WJWDAehCGBYKUada2
 11O+X2Gmu4fCKyvXu40F6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787817782; x=
 1787904182; bh=QpUNZB+0iR5Zn34gPuviCPOosJmixfmuVU3jGsigAI4=; b=g
 OqmAgIqeDSzaNCPQkCObo3cEbbOivUzDvuCASfgGYH4EmvI1dumw13UylYRwpnvd
 +PeAd7hgbBBJEQWaOmf7tja/qMd4dyNeltfl0QuV3mybZZaQ+RZn0RNGMxfNVSzR
 lBl6+qdDUMZRSuo+jiIZK3hFVrdKHpwwo1OBZYFINStoZ4pZjX8t10MpTsqHex7l
 zDF+j0GaE99T4oKEQiZkH3dk+wbsVaUswJzmZzR+41bKjFOdNjVciHTfS9LKkSKy
 i3HExHxt0KqyoRlQsRGVmZLRLMg3kM0bWjPxBJpwekODseLpKuLetRrnf839nF3G
 6DY3QvE7OUvRi/wC6EAOw==
X-ME-Sender: <xms:Nu-PamyEUuYxr1kiX5d6cRAlkfkM1UnC0gm-ZHOeSPaLq_ny7r3KgQ>
 <xme:Nu-PaibrPPrwbCnxYsZOhKo8L1xAlFjqLUJBg1wbAqfhGL326lN6LRnlRJfrvCK1h
 hdxuayrNAoim7UYoh-YGM35NKHKeQWC3RBYAYYW1m91BJxh56uG7Qw>
X-ME-Received: <xmr:Nu-PagRND3BLFCbr9rv4HwGmrM1Q-8AEpGwMcQrrHOn70_UcRQh9P_0gaOrlv745Q2L3EjCgubCQ-ILJpemF>
X-ME-Proxy-Cause: dmFkZTFUNovOjyPybIRO77DW9l95ej/djm38TdgmTIsRBMDw/rqyfdOJUp2jYibJoDUk4n
 Qpwb9d8GuWxwzUaDEtI5W8zMO80y2mp6JyaJ9bXIsydEgPjBsi4UhrALx/ST8XC59bGotR
 jMgnlYkajpBZA5EOlDO+/jfrGmwC3hpi96ksjzyjmj1NoExldaTbcnRhEQjLCtkD0TPZDG
 8GSgQrzmCYuX2UzbkXZPdboFnKfkwR/2F7krCLdT2tcO4aKTK/4l+5475L5f16hRen5Jtp
 Emx/yV3FV8bAZWlASz9BHJXeNiDACDvoF6QikCEgJ+RLN4FY5gC7TeYmFtZarDXt2BzKTc
 dzKbU8P0HdHKTfOGIVrW0Dc0zEHJX43IXr9YC9BtCOtINCcx7nTO5eoKu25giyhfil8Zqr
 O46UgiqZTzJgkYpFhvgGHwfFhRLdUB7RqvY8VG58GveTexTCrwwyI1cBwClMYN9vebpHkX
 jStWb0gWR5T1IKxN3mhkXHyuic+Od/0GA3Csxme8oSZ835/meGDU0hcDleG0XqhHIUFOq3
 r7CAMBGrZO3GDdFz1G23353p8drNcPXkUAsHMveTrp5+jz9WdUE0llJnbIAxT83EDfNMSH
 fsUF2IYGyml8n9y+4QnmeCLbFQz8qYl/qvqT5rI5fmqqfOS3bL1s8680CR+g
X-ME-Proxy: <xmx:Nu-PakwjlFDLeqQcq9FGUeXP-W8JyOiwBRaFc-WK85nwbV3fFriLpA>
 <xmx:Nu-Pai1dw0Zclt7Ozvwo_rnlA77I9RzgtHdlMbD4mgLqprYTKmzt8g>
 <xmx:Nu-Pai4ogWvSz1VQ74V6bNlAlhWQ1kM6Spi24ctxT5fxZsln4VHTsw>
 <xmx:Nu-PalWlwGtzFhyVEltuDtwV9rOI9A7N6hTWFZHjiYb4iRUEPbDl-A>
 <xmx:Nu-ParOD9JW4ZkjOt923_2Eu1GlY5-oXrlTJvEMGuMPYvIniXa8SwBEc>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Aug 2026 04:03:01 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Ori Kam <orika@nvidia.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>
Subject: Re: [PATCH v1 01/21] ethdev: add flow graph API
Date: Thu, 27 Aug 2026 10:02:59 +0200
Message-ID: <HqZjlEL3SW65SDlgi-2Ipw@monjalon.net>
In-Reply-To: <4be95b58-6327-471e-bac6-57b7d6e5b37e@intel.com>
References: <3284b12762de6e3b7791f5e3fa63c78b26ed5e6f.1787233987.git.anatoly.burakov@intel.com>
 <IR-o-Ca4RH6Rr1n8j2NshA@monjalon.net>
 <4be95b58-6327-471e-bac6-57b7d6e5b37e@intel.com>
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

27/08/2026 09:58, Burakov, Anatoly:
> On 8/26/2026 4:46 PM, Thomas Monjalon wrote:
> > 26/08/2026 12:20, Burakov, Anatoly:
> >> On 8/26/2026 11:21 AM, Thomas Monjalon wrote:
> >>> 26/08/2026 10:58, Burakov, Anatoly:
> >>>> On 8/25/2026 3:55 PM, Thomas Monjalon wrote:
> >>>>> 20/08/2026 16:00, Anatoly Burakov:
> >>>>>> This commit adds a flow graph parsing API. This is a helper API intended to
> >>>>>> help ethdev drivers implement rte_flow parsers, as common usages map to
> >>>>>> graph traversal problem very well.
> >>>>>>
> >>>>>> Features provided by the API:
> >>>>>> - Flow graph, edge, and node definitions
> >>>>>> - Graph traversal logic
> >>>>>> - Declarative validation against common flow item types
> >>>>>> - Per-node validation and state processing callbacks
> >>>>> [...]
> >>>>>>     lib/ethdev/rte_flow_graph.h                 | 532 ++++++++++++++
> >>>>>
> >>>>> Are we sure about the name? Why not "parsing" instead of "graph"?
> >>>>>
> >>>>
> >>>> Because it is intended to help build *protocol graphs*, not *generic
> >>>> flow parsing*. I.e. only things that lend themselves to be represented
> >>>> by a graph would work with this - things like conntrack wouldn't. So, I
> >>>> feel like "graph" is a more accurate name for this, because this is only
> >>>> for enabling the protocol graph walk, not for full flow parsing.
> >>>
> >>> OK
> >>>
> >>>>> Is it only for drivers? In this case, no need to make it a public API.
> >>>>
> >>>> Yes, it is for drivers. It is not a public API, it is not installed into
> >>>> public headers. If there is anything I forgot to do to remove it from
> >>>> being public, please let me know.
> >>>
> >>> You should not use the rte_ prefix for files which are not public.
> >>> I know this convention is not well followed for historical reason,
> >>> like rte_flow_driver.h should be flow_driver.h
> >>>
> >>>
> >>
> >> The fact that it didn't look like there was no convention was why I
> >> picked rte_ prefix. I'll happily use a non-rte prefix for these. Maybe
> >> use eth_ prefix for both flow_graph and flow_driver? Or does flow_graph
> >> work fine?
> > 
> > I don't think adding eth prefix is needed.
> > 
> >> [on a separate note: should rte_vfio follow suit and be renamed? it is
> >> no longer a public API following my patchset. renaming it to `vfio`
> >> would probably cause conflicts with Linux headers, so maybe something
> >> like vfio_driver like flow_driver?]
> > 
> > Yes vfio_driver looks fine.
> > 
> > 
> 
> Actually, on second thought, "vfio_driver" is too similar to 
> "bus_driver" and "dev_driver" which kind of implies that "vfio_driver" 
> is for writing vfio drivers. Maybe dev_vfio would be better?
> 
> (flow_driver sits in lib/ethdev which is a driver subsystem, but vfio 
> sits in EAL which is not, so for flow_driver I think "flow_driver" is 
> OK, but vfio header is in common include together with bus_driver and 
> dev_driver, I think vfio_driver would be confusing)

OK



