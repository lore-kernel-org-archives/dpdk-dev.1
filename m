Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1566EC61DB9
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Aug 2026 13:55:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2CD074013F;
	Tue, 25 Aug 2026 15:55:36 +0200 (CEST)
Received: from fhigh-b6-smtp.messagingengine.com
 (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
 by mails.dpdk.org (Postfix) with ESMTP id B0D06400D7
 for <dev@dpdk.org>; Tue, 25 Aug 2026 15:55:34 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.stl.internal (Postfix) with ESMTP id F3AED7A0124;
 Tue, 25 Aug 2026 09:55:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Tue, 25 Aug 2026 09:55:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1787666133;
 x=1787752533; bh=tKWcmGqk/HwlDyPgQQ2IyzDRuUvy3LnVhHL5tLGcQ8M=; b=
 keAiTtUfIzYQ8up6eLqGZnute9R8wIwQfYYkctxzOwbDqystMOf/mhj4n3lYNp76
 J2KoyeGIeFxFAkiAvf+RzDC1pwKlSTepouZKoHt14TQsbdofodpuQgszUyn/RliY
 FN2jYishRHeO8KkT2IUXAGgqrSPsGvXlWzkaj6Vcc5IcfN68r6qJAnnJF1cPNFsN
 X61Y+U5UoPnOhh4Me/BJtgs/F7kxvb0ZU02t7dPpJrqfgoPSF4GVrz0T7ngdT1gl
 KuOxNf6C7ooCKPd+rbNjfSgtfrylMrOF5P9u2GmVk+DVxfXbziEXhebFIWLJMNfU
 h/WD+QewajDwaqWg1Vu13A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787666133; x=
 1787752533; bh=tKWcmGqk/HwlDyPgQQ2IyzDRuUvy3LnVhHL5tLGcQ8M=; b=V
 bK6bsLHwYRQ2bgNX9m00N87j4SW+5unzHdpUEHLOfEYVlIwSNLp9y7UMYxj3K6gv
 ubGWzh2XAhWb7wWBv9Uu7DeHobhX5AnCAJbdKfhKBco2KSCQYuJQApK4ysNwI3bE
 tczZzuGhSLWe8mma4y7fMs+SL++ZWl8owHCSW+7otJ6FUqhJ1uTw/LU1PrvDy5Et
 i6c9KcqyAyHjI0/fWRrqwNBHfwArStt+DfMoCjXXGbq3vO5jZI/MiTTX1nfk6pRI
 BXW2GhGpeiDxOYWMTVm6Y2Dm4H2PwFlrr85dTT0hlWViK3da+NXJVb/RExmGrBmS
 ZbQpOpVKGtpESFRJCFYGg==
X-ME-Sender: <xms:1Z6NaoCY0pm3BKHbOBobr4g1TyG6L-zEVjNe6O50Zjyz1F2ptvgyrw>
 <xme:1Z6NaqpvP1RFWgTOd7EaBvuQW8um0NRkiY6J8pMTvYD7MiplcGB2mNiKxPAddT89s
 CdQHRt3eQ5M_1zwIuEi3kqBHnxFxaIr1aTV89IqxHJ3TQWYZmEmEA>
X-ME-Received: <xmr:1Z6NajhR4Kfj7RlWi9IVQmE8iJeDnVp4O4fiua9i_XNxP2OhfW8kuiMqC2JxWeXQFie3aOl6ofWml2lYYqDfIsVYbQ>
X-ME-Proxy-Cause: dmFkZTGy7ZYFxxidkEDYFw6ZybWUiFGGzEw30oqvKAAx1rm6a8LQhBqdX+8CVo6PaKgPLG
 MHD59wbG/FQLlHcDhXZc9v+gO7Opf3lxh4vk8sTMzwqRLcIaswjhG/4hbsMBeniVlC+Njo
 pD2Agw5prUIgCaOXbS2RyA9GKmpkatmha8gsJ/+e7Xmro6DnqR6pRM9a3tvbMyxdaY+xQz
 HcfFe5Lv4UIV57CtlKNGKmcsDXypXgSfGmbuJTlvK3Ox+ZSZB7a0axKDSh8Qtg98PVJTeB
 2/Z6LOzkSNbyap8y8jI/GVxOkl7zpAARCfY9I3IegrtCwcMNHRgX7gXXJbllpkTnfvyCYL
 knf1x4UjbfQGeT6OZB5CFwajLjKlO0EoD2oJ0E5t2wLb3Pe83jM8NU6UBuF72kjKm0q4fl
 xiZxzmmQEQ8mE5kHMibbt4XZw0UFjsoFOLR0Bek2PT82VEcIGQJcrJGBFzZow/81hwCPeD
 al6jnMWwifsRMrjk0Of5X1V+qCeSeb+6SL7CP+IOWM+bNSDZfGIN/WQD1HC77rI5jQCc0t
 1xturK6VqM0DpZXqXAGiwtjdNJOnCZiayxFY0Bd3hrLleF6ev9n98J2jjcrfzdpWsLcrTr
 ZLzGDyOf/W5WNHu6gg5izpclB+B/MOo9j9wqzvxw0JuNlszXEYvgEn8C/XDQ
X-ME-Proxy: <xmx:1Z6NanClSdZYhugTeTlgSuY9IvMQFQgKmzMwc4CzV-2POOcZvO1I9g>
 <xmx:1Z6NaoEeKHms2xGjwAv3GYRP5H11tFvYtDilzpdy0GjnPelBNZoY1Q>
 <xmx:1Z6NavLwiHdi6uVQUIEa8lB1dSt2kvzjNyscx8iAj4-LqJgnVYWXNg>
 <xmx:1Z6Nask4IZZHSJIUZeLNze4V2nWyDZJMQ-v1XnztY5AnBB1cvjCZdQ>
 <xmx:1Z6Naifhh4YPbeNWWyOYh7V8pzHoG40I-28I3WkiTUuYkv63VDEASbNF>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Aug 2026 09:55:32 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Ori Kam <orika@nvidia.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>
Subject: Re: [PATCH v1 01/21] ethdev: add flow graph API
Date: Tue, 25 Aug 2026 15:55:30 +0200
Message-ID: <DPk1E-kwRJqv9GCxmKhBVg@monjalon.net>
In-Reply-To: <3284b12762de6e3b7791f5e3fa63c78b26ed5e6f.1787233987.git.anatoly.burakov@intel.com>
References: <3284b12762de6e3b7791f5e3fa63c78b26ed5e6f.1787233987.git.anatoly.burakov@intel.com>
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

20/08/2026 16:00, Anatoly Burakov:
> This commit adds a flow graph parsing API. This is a helper API intended to
> help ethdev drivers implement rte_flow parsers, as common usages map to
> graph traversal problem very well.
> 
> Features provided by the API:
> - Flow graph, edge, and node definitions
> - Graph traversal logic
> - Declarative validation against common flow item types
> - Per-node validation and state processing callbacks
[...]
>  lib/ethdev/rte_flow_graph.h                 | 532 ++++++++++++++

Are we sure about the name? Why not "parsing" instead of "graph"?

Is it only for drivers? In this case, no need to make it a public API.


