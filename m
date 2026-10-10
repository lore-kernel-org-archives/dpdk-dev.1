Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FEDCA9EBE
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 05:45:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6195D4026F;
	Sat, 10 Oct 2026 07:45:27 +0200 (CEST)
Received: from fout-a7-smtp.messagingengine.com
 (fout-a7-smtp.messagingengine.com [103.168.172.150])
 by mails.dpdk.org (Postfix) with ESMTP id 7B5884026D
 for <dev@dpdk.org>; Sat, 10 Oct 2026 07:45:25 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id DE5A0EC04ED
 for <dev@dpdk.org>; Sat, 10 Oct 2026 01:45:24 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Sat, 10 Oct 2026 01:45:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1791611124;
 x=1791697524; bh=pe5sJp+lp7s1qlUwsqnVJuHinpZIuXPjfcaqqZtBb7o=; b=
 Lr09cXqbbQ2w3CZ+uCdaxk+zpGUFFcmxkQQ0JzSP9CLadi1vK3ExCANXJ1Fcj/Ry
 TlD3tAoTq5b2D4GCCYjdcUZmd97xyLseOAoucbxC5ihbvq8lQDRHNub/BSC2+No0
 nafV3g/NOLBTQM3/ST/PYfGfEINbJESMXKzJtoxHZ4pONXCw1Uu6fkv/FoLTHPxX
 oxVpWcqpJOqAO1TeDZt0p5aPXjY48uSRryyvNmr1IZVNyt++8llHTEEJ8tA92v52
 hmbcd9YHGeApRCXMHnNQvUNVFz3wcPO7YCsaGybENUzrfRfRVxyKn2p2WdhUchOi
 JdLclNu6QHTW/i2Dy3k6DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791611124; x=
 1791697524; bh=pe5sJp+lp7s1qlUwsqnVJuHinpZIuXPjfcaqqZtBb7o=; b=R
 /M4UUC1v5hRMIGeouZYZfU9/N69R3sZezp4jFfoT8UnonA+Y/gLqdDn6KIhYUv9E
 tBQbFza6snyrGygEcS7XYjcfmYuhxWLvdC7fyy2MadO5uU8+uCkKyxTCBZ0Fl83K
 YLZmMOigfD0X9XkChKXCaE6jqcAkHvQriBH57dM9R9RXZsf3HoBVEqjr/J4Ao4ot
 JIkirM7x2eVXCGK+/R9B+Inx1h4EBptpI1IzJ+ip5qPO16rHsUJ4lyOMdBc2Nnty
 87ZYeEIzJ9ERr57dJR944FwqY2JBNDKAVWrcj9gBU/rGac68VRxy7/6hIdH6JopO
 BCUOrl3zivtKsxtEi4LeA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791611124; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:fWziMEa9DVJ5ck5iolrh5VLeMVkU8fIelMQFh0ynXEFq7Aq
 9B0qGf7zUIbHN/5gcMKUpsL390VoM9vuRrarz8rXQ3ScmMvyk84ZwTPrVQ4qIu3v
 UT9NTmkZr1IrsJlX8nozuu9hNl+0mG+M9mq2EdpEgc8kdcnOZz/9aSNw52Wci6Os
 cTyJxsk01FbxKWrb1KKxo0DhFSQswqG8G8/bRBoWamX368pZ/UUXNywKv44zsipZ
 ZDe9NDQL06A+0bfdS9pYHZEoWwzqe4BfzjtXAztwuxVOZU11PDo2lScx48DyKHut
 kbH0PamWKHwMsInvpEnSBR98rBYI2TbgIPsSmew==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:ySSNGiJbU5C1xJmmpvWyiHUrQM6LptgRoz68ABGpMT8=:djs+ZgSwAdmMu020cn1r588UwV9Cv67knACRvGw2EIs=;
X-ME-Sender: <xms:9NDJakScp3h3JVjGnnCb_otNCE5TwSVdyg7JaiIgJpGy_LP4euHl2A>
 <xme:9NDJah4iBAfswWit1qERzgwWk_VMA1i3lUW4hrirxa6UaUM8YTUaNRD-nDtFxim04
 LQGsTnaUAt9OYN9W0ZgzWMDZL8fQ3IVVgUdzfOx3OuCXi2McGiuWZI>
X-ME-Received: <xmr:9NDJapyE5JhcjhlVsR1XnvdreHl5S45LOf41q_Us3fTd_FVt5CooqC1tllIZSmdSXCwCnsfsoFP0RMeyCzXX8TA>
X-ME-Proxy-Cause: dmFkZTGDUaXxNHpow9RCadf7PhUTdiIjI4d6w5V289dvTNGp7AJBtG2zCik8SyNJDM/p5j
 /s7N89Cw6lb5+McfNWwQPdvBTjlL4Zt+jVruTwaveRk5SWW6QBo9mzQ1DOZg6s17RH/atW
 ifXok89L0TgEKT+ffxDYKCiAy4F6oRcwK6JJ7kfZ02iM8S1coAtaZX48BhRn6/jJjZRyqU
 utvD7LNrH+w31V21MD/SucxSCf6jrkNYSOTfJyzzuQ/tV5d6C3jBTkxEFnTYEwf6z0NLhN
 akYol9ru57cq6tO8FmagDYrVr6YULkBMxJadgG0JhBcIwGrvpBFYCgFchdSIblA8HKECqZ
 5uf5DRv7az3aZfDZni9M9bzs2BOymZEmLZeKERFZzPYkRfWFRRhJpJq/0da3VyBXerqZib
 Dzh4SRqYSeD6RYPXBgR0Bvz+pmCQlQbrh/xRnNpwIoUktXnWopR+emX8pJdXJEhkd4qa/W
 BgerXxxZzAjJwkLjLTTbSxAT899WAV6QHz4zXMRPQ2HavV2YR4ohvXnRhr7YW2mr4sPr58
 ZEpBWwQFbeQnAH6GVfiDfVZI2lYtKPuzrl4k5v16OAFYbdWM/UdtmkJBaTj6rHo8QIRreo
 LKK0FISC7GRvRA8y18MgvuEt79lRCdBBqXyQbFS9MEbT+6E8JyRUQA60DASA
X-ME-Proxy: <xmx:9NDJagRfb1OXNLNjocGxYNQAA38iScBNM_bJE_B0ga5bFHiM_pgZPA>
 <xmx:9NDJaoUaYxPR1Tnpd_Sfd7zofd3XXYyHKKSHF6n-PNEVX_DcOPNJ7w>
 <xmx:9NDJaqbWwexSPZMtwIYjxQho6pHpOIUP8iovhTQsPStD25IJNYqDwA>
 <xmx:9NDJam2-qndXB-65Xia5Bwq6B4Q6jmaxUS9l5Z8_ki-kROcvRHGz-g>
 <xmx:9NDJav24WcdiihvMgD9ZqeMmTOZ222Qr2VRShoc63dt-Wndl7dTO3mfx>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 10 Oct 2026 01:45:23 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Roman Khromenok <roma55592@yandex.ru>
Cc: dev@dpdk.org, stephen@networkplumber.org, andrew.rybchenko@oktetlabs.ru
Subject: Re: [PATCH v2 0/4] ethdev: report module signal status flags
Date: Sat, 10 Oct 2026 07:45:21 +0200
Message-ID: <xAVQX2oSR66gxZxbOBd7tw@monjalon.net>
In-Reply-To: <20261009205741.550421-1-roma55592@yandex.ru>
References: <cover.1791482259.git.roma55592@yandex.ru>
 <QfuRvLIpRPi5pHmcYtqGrA@monjalon.net>
 <20261009205741.550421-1-roma55592@yandex.ru>
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

09/10/2026 22:57, Roman Khromenok:
> On Fri, 9 Oct 2026, Thomas Monjalon wrote:
> > This is specific to networking devices, right?
> > So it has to be linked with ethdev probably.
> > But if it is not specific to any driver,
> > we may consider moving it to separate library.
> > I'm not sure which place is best.
> 
> Yes, these are the pluggable transceivers of network ports, but
> nothing in the decoding is driver specific. Drivers only return
> the raw EEPROM bytes through the get_module_eeprom op, and the
> decoding follows the SFF specifications. The decoder (about 2700
> lines) uses ethdev only for the RTE_ETH_MODULE_SFF_* type values
> and the callback typedef.
> 
> So ethdev would keep linking it, the same way it depends on net
> and meter: ethdev depends on the new library, not the other way.
> rte_eth_dev_get_module_eeprom() and the telemetry command stay
> in ethdev and call the library.
> 
> The decoder is also useful for ports which are not ethdev ports:
> in our firewall, the kernel ports are read with the ethtool ioctls
> and decoded with a copy of the same code. This already works with
> rte_eth_module_eeprom_parse(), so a separate library is mostly
> about keeping ethdev smaller, especially when CMIS is added,
> which is about the size of the SFF-8636 decoder.
> 
> Keeping it in ethdev is fine with me too. If you prefer that,
> I will add CMIS there.

Having it separate would be similar to the net library, yes.
The ethtool case is convincing me to move it to a separate library.



