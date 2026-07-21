Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AF5C4451C
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Jul 2026 19:37:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 200ED40294;
	Tue, 21 Jul 2026 21:37:25 +0200 (CEST)
Received: from fout-a3-smtp.messagingengine.com
 (fout-a3-smtp.messagingengine.com [103.168.172.146])
 by mails.dpdk.org (Postfix) with ESMTP id 285C94028E
 for <dev@dpdk.org>; Tue, 21 Jul 2026 21:37:23 +0200 (CEST)
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfout.phl.internal (Postfix) with ESMTP id 722A2EC0100;
 Tue, 21 Jul 2026 15:37:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-11.internal (MEProxy); Tue, 21 Jul 2026 15:37:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1784662642;
 x=1784749042; bh=zt+7qP9dSdy9lHr2cuN4HHTEvehtM3DPqIiAUrUe+a0=; b=
 GcpDNk6dPf7WpoTX6DTAeCjVowEkHcFnvYZ2tBjjNDspr9JZgjXlEIFw/4Ujv5Kv
 iIbjHIpNIHhHApFrfvV9KrsEYmi7PkSFEs5eERJmdWM+Erb1NMgGP8gPCkXZ+8sO
 2yHl7Vpl8DN/o82/EZttuPDuTQioVKSx8uubv/6IdW82ZGzUJoyE8gEIzgYbwnKB
 2rx/UIiVG1LcYkLoiCDXeD6zbNQE0xCcWCmfVhwqBcp+wIQl35rpN8ERyhgLpcO7
 ZG7/dcQWsFHeM8hO6DIOCWjY0iE486KSyjBN/s7cIYF0lrdl3SjLHsUgmL5NPIEn
 IYLWLNy9f2tB+DkN8UFymQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784662642; x=
 1784749042; bh=zt+7qP9dSdy9lHr2cuN4HHTEvehtM3DPqIiAUrUe+a0=; b=U
 mkHMhJJdmdJZMDk8eQsenZ7kkfAoixSTxz9uZwK8fbIkywsf2cREO9Nj04HQCO84
 6Yh30UMD5DYtdUqwZIRlPIo/IpXsyqCcsAL18YfsIJMh9RbHoy0XlcKpxoLC4L+Y
 5n504Wsr+x5uUIC2mMjqeZgX+R/Dj9JbuXe2YE4dWJSyav7uPHgeYN8daL5CqzVb
 fLJEtDUag8hSNVU5uFwtUHtQWKDpUqG+drqlCxF4qjKV2qa9RUsjDPIa43YbLtaE
 R3X/1ZRUq9M9r1HdK0OWOzmOuON/NBnCV+wb8pxlVuVUIvlbenYdp5VUmlHTWewC
 aXqQB+fYYaZWvkSfTFxfw==
X-ME-Sender: <xms:cspfala2mi6NbYGUr7TLHtdXB3BLkzQu5Xj0PXWDjemz3cmGBNs_Jw>
 <xme:cspfaovTo0QG5AhXhrqi1ZytnMN0QxrE5jkUNPBkD2-7IXJyGrUIAkO5LCJtVOcut
 fzrMSljgndbgR-LEAKJXNOLC3NDN-3FqAaH0c5bDGBo-K6aZ-Py9MI>
X-ME-Received: <xmr:cspfaqv98ga7PUQvNdNLAoOpRs3kvRnF-IUEiaiVQ_6oZ15sW1vnZlL9kCcFXdXjRU_IdcRlChvTywfZouWvVbljNQ>
X-ME-Proxy-Cause: dmFkZTGbjX8s13TncF0Xb9XJeHRIiIPj+rAc597oOQkLgVNfhgLVGN5F6D3/yq3RnZD22o
 1vTbQ7TqMZt+yXIbKTugguxmBOh2TyVkZOwNcwd7xrwesnvzLFX06ljJ95FutX/gBUlkTn
 yEb89ZLsIMaxff3hZioLlFPW0vUHenNIbp9Ra34zBgMeLKNge7Hd0B7al/QgJtlkh7Y378
 tatPC+/PMMEPIRaaz7sVM4/8gCpLoSY2hKGiglh+0Lh12aA5PZaVvSZDfhxPvJgzJRH1L6
 CmsXG0fsMU/RUS3o3koWrgyCfxWu1dWfdlSaKxv3uzXgl9IqH8/a3FzoUiovOHnP2upsd0
 LicZIL2che2M5ibuC/KBPD5RkH3e5sJmAmEHe5rhSQfAu8jsHXrQTSAcNPjBpABovRYAkz
 MUAE1bcNT53lFSS4/Nxx+QKKbVCrQi96NCxFjREq6wR6PuJZVMmSK1qYw4+lOwopT+H+Vz
 roV75otrJgsJZLPMNrMNuZIok13Pw1l+fnDo7JJCwQ72krV1H2/6VHdj8K5fzjzMBjAack
 EuzQMx5c8VSwuchuWelCYJf/AXJWIfQCZlnBge57O2gqj0hNn1cMIAgvnBOQlOKCKJWutP
 ImIfF2Z0fL2TO20r26yAZwY3uuQ2sPA+GhFPt9Xf1CGxYPy01V+RgaF2MicQ
X-ME-Proxy: <xmx:cspfaldDlUEC1lJbz8W-MHpa9iyygci0tleLEHr910cfMhIzMcz3tQ>
 <xmx:cspfajbMisGSB2IHwN-Xe7VCpokI8Wy-hb6bMAcrf7r2fDENYY3kKA>
 <xmx:cspfagXAM1lYMc0UxWAb_V32yN4kBmh0sWZUVs86E8K6muLOfGqdkQ>
 <xmx:cspfati9772-XWh-HKUpm7dGA6ZyG3i3ynWFWfjrdTB9ikg2AUgOoQ>
 <xmx:cspfapBi2umezMcJqroQeB-wTuXDZdkDhQYB_la6J4Db9kjlec4z6stT>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jul 2026 15:37:21 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH 3/6] doc/rel_notes: keep library updates together
Date: Tue, 21 Jul 2026 21:37:19 +0200
Message-ID: <wjhKUFwCR0mgQVZuWGEQ4w@monjalon.net>
In-Reply-To: <20260721151325.2698283-4-bruce.richardson@intel.com>
References: <20260721151325.2698283-1-bruce.richardson@intel.com>
 <20260721151325.2698283-4-bruce.richardson@intel.com>
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

21/07/2026 17:13, Bruce Richardson:
> Group all library updates and enhancements together before driver
> updates in the release notes.

The suggested order in the release notes is:
     * Core libs (EAL, mempool, ring, mbuf, buses)
     * Device abstraction libs and PMDs (ordered alphabetically by vendor name)
       - ethdev (lib, PMDs)
       - cryptodev (lib, PMDs)
       - eventdev (lib, PMDs)
       - etc
     * Other libs
     * Apps, Examples, Tools (if significant)

So it was placed here on purpose.


