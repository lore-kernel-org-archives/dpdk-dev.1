Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24106CD8CB2
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Jun 2026 14:02:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0339A402B8;
	Wed, 10 Jun 2026 16:02:19 +0200 (CEST)
Received: from fout-a2-smtp.messagingengine.com
 (fout-a2-smtp.messagingengine.com [103.168.172.145])
 by mails.dpdk.org (Postfix) with ESMTP id 332314026D
 for <dev@dpdk.org>; Wed, 10 Jun 2026 16:02:18 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id 9661FEC020E;
 Wed, 10 Jun 2026 10:02:17 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Wed, 10 Jun 2026 10:02:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1781100137;
 x=1781186537; bh=eLeLqFNiUKUUkB/JlnCayxvMVSVYV7VWfh8CFP/iupE=; b=
 uaoZZh1t2ye1U65/ccT5yUQGKjgMIAH2muElITgHtsZvTrRRK+jnJQ4dHM1npbmz
 yOWu1VnKiT3P6uB92UTmGPAJK3suGmK+VWvGhP9WSOZtmP8yJcktncVPnnBJPqRI
 nDMpoJM91qMI3gDBrj6qzktIAj+nKymS8vVOYTsdNkXIdB/AkGum6jvPFzZdWlOA
 g5bb1ophChNEUPi4bkMhMuQKbY1UK52QeeXrll9iq3TSaC5xZXLWjQdXZxXcWaik
 kmUzh3qMrTVs3AzUe13zyt92zAJCNpslAwPCEaSRs8uQkQavoQRIFZA8kgziN65q
 lNp9bG8u/LptyVUCIAdN4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781100137; x=
 1781186537; bh=eLeLqFNiUKUUkB/JlnCayxvMVSVYV7VWfh8CFP/iupE=; b=L
 +nNNK6XwTzK15gu3NqNQq/dfgQV/tOLRCv/phssXJZDZxsqey03AJl/rc602ubo3
 7v7afoZ3vrT1vqxRIDb/Ntj1O1qi3Xjy504h4T35x58HYQCCRbuImU5GiNyEfz9N
 8uY4NmBvo8tvzsSkuMyv3iHtp/DER9pbbIRTaiRbN/1QxyLI7zsFazwgUGc+oDt/
 tVqQMzJjM/ubUrD6f58EEhooCLg8PqJME2U772MvXEunipAY4f1SXQArSf8g7oOy
 BjHCa00F8XLTsHRt9IeRQSrKSy6jDMRX5ujlsGw+Tb+Cn9scxFOi7Xv6tqXMPVzX
 XwIA7f7X3YHt3u40Hf/YA==
X-ME-Sender: <xms:aW4palTCU4qFvcoVEvpLIysq8GQ_fJk3m3MppRQxTXd8vG6hDwlIPA>
 <xme:aW4pajEhScGiS987xMdJGAdI5zYomJ5mHXR_YLU_C6XP0RGEcbaA5I5yzWfln0rHr
 IKqD9V3thVwBlXFVBfq68KSb6iKu0vED2UFf6f4a2IHIdZtq74qeg>
X-ME-Received: <xmr:aW4pap_atfI3Fk559VGFpf04FgqsutZg9qIzw9EuHzKs2I3lLaBWX6OBfkPs4a3cOYMlv5m4fshnV6j1U4kE_QklcQ>
X-ME-Proxy-Cause: dmFkZTEXclm11/aMZYJHnFbI2tEnHu9Izc9BfWSb3/iyebUVOu0PW6K7FwLYV6MoSzPGe1
 UOKKCCagkmVp+AibEB/wrKreGNxgKzlQc8PS7r1g0aaKlUJ5Dlm/nawQYI0pCD8x3Y2e9b
 OZvuv5rdEZWLEqHh10Kd7xtaS6CZGl/99BPyNRqaftyQ2EwmhoFH32r8MHPgQt6rRF5A5Q
 mQAN36G3j75RV67Wk11N5ic8Ybxsrdl1JcprcgRWp2ukv44hS5pBijSGssYFBNgbAz5uWq
 qWI3DWQje74U3KjWZxvkJag00+STAQvNs6HAxxK3vyrr9XMW44kHKQBnB0BobLXMK8LIfu
 1wcVUot2ucb9xqnVPbACMkfT8mmMqhKIO8CQT8Ie6oF3Ufrla8+SYaCkkYPvlfAS4nT5Vb
 yJyEpZ27bdG8S8i2X1QOGzGKEJA0c101xcxFP8/Q2r8VpWE0eY64vsjBh7Fpz63Nx5CUEh
 7nkcSmkGTkSkEB8zmMH2t9v9AHras/bfZCuUhHN5pO2z5DdKdZIatXdy78RKW8Bz/uyT1w
 YawO8I/XB2uRQgpdY9AYnL6MDkRuZeK2lWaxY3DWayMm6eHnLzh5VDBufbFwvjlnirbef7
 FO6iXXNBwNhrl3TXhR7jhTMpEDar8OVzQAEXjKJX9MBQ7pKWvgYqtJMCHX+A
X-ME-Proxy: <xmx:aW4palLnPthFHMCVNGdj1fbqDBFx5a8Yz1Hzs4x17SgFSnlzGV2SJQ>
 <xmx:aW4pakYysiZ-xPUPKnUoIUtGs_ic6ivJng-sUr9G0MThSeVu-Cgncw>
 <xmx:aW4panLPXIhKe-RuRPlYQ1DAhTJwpRKX8ajyFt-4nK5jMC9ve_mb3w>
 <xmx:aW4paiA7XvXx93TTwO2a-8K57OYeibaMgSWbeGjQXhA3nixXuKGyHQ>
 <xmx:aW4paqRiOj7UUj9FpSvC2DlqzGCXxJDuE-l6S96-cNP12NtjPLWU2scn>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 10:02:16 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Jie Liu <liujie5@linkdatatechnology.com>
Cc: stephen@networkplumber.org, dev@dpdk.org
Subject: Re: [PATCH v1 00/20] net/sxe2: added Linkdata sxe2 ethernet driver
Date: Wed, 10 Jun 2026 16:02:15 +0200
Message-ID: <GfNoEEuaTxKZNwCazSoaAA@monjalon.net>
In-Reply-To: <20260610013936.3634968-1-liujie5@linkdatatechnology.com>
References: <20260609013951.3359199-21-liujie5@linkdatatechnology.com>
 <20260610013936.3634968-1-liujie5@linkdatatechnology.com>
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

It should be v15.

10/06/2026 03:39, liujie5@linkdatatechnology.com:
> From: Jie Liu <liujie5@linkdatatechnology.com>
> 
> This patch set implements core functionality for the SXE2 PMD,
> including basic driver framework, data path setup, and advanced
> offload features (VLAN, RSS,TM, PTP etc.).
> 
> Jie Liu (20):
>   net/sxe2: support AVX512 vectorized path for Rx and Tx
>   net/sxe2: add AVX2 vector data path for Rx and Tx
>   drivers: add supported packet types get callback
>   net/sxe2: support L2 filtering and MAC config
>   drivers: support RSS feature
>   net/sxe2: support TM hierarchy and shaping
>   net/sxe2: support IPsec inline protocol offload
>   net/sxe2: support statistics and multi-process
>   drivers: interrupt handling
>   net/sxe2: add NEON vec Rx/Tx burst functions
>   drivers: add support for VF representors
>   net/sxe2: add support for custom UDP tunnel ports
>   net/sxe2: support firmware version reading
>   net/sxe2: implement get monitor address
>   common/sxe2: add shared SFP module definitions
>   net/sxe2: support SFP module info and EEPROM access
>   net/sxe2: implement private dump info
>   net/sxe2: add mbuf validation in Tx debug mode
>   drivers: add testpmd commands for private features

There are big chances that this commit is too much controversial.
Please remove it from this series so we can discuss it separately.
Also it should be split: 1 commit per feature.

>   net/sxe2: update sxe2 feature matrix docs

Please update the documentation atomically in previous commits.
When you support a new feature, the commit should include the related doc changes.

Thank you


