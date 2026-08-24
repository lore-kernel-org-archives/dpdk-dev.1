Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A301C5DF81
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Aug 2026 20:38:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 724E54027C;
	Mon, 24 Aug 2026 22:38:44 +0200 (CEST)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by mails.dpdk.org (Postfix) with ESMTP id 4B971400D6
 for <dev@dpdk.org>; Mon, 24 Aug 2026 22:38:43 +0200 (CEST)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-ca7c1176317so3368874a12.1
 for <dev@dpdk.org>; Mon, 24 Aug 2026 13:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787603922;
 x=1788208722; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=raF7y7IF+ob+Y5n6rCm1SnImd70Glm9VI9f/jhLtrzc=;
 b=vF2EgyUqDsWynWb3Q0XJy3amNqinmj20v6O6VNgaL7Y9uh1kAdjz/srk5/tm9sBpV4
 zXZ3YS73OdNwdxPptp5cwRdzoULDat3esDFU3Ys1qrCFvY4/ExiJkUe7AQ9d9zAtAvkO
 0amGWHzKj7QwDy37zYNijcTB7eVGGM7uJgQFB1DW5LGLN00J3naKekjCZsL2IkzzfCHY
 j+yYQ6D5XQM3eNkm0SPOLmTRo9EUX2Fy/zWdXLIRVQVXm2329YcCvud84FyjdZRc3F4S
 +kL9NbAKCKfy2RINvEkpa6BnCIHDBDdg+TJDT7rnhjBgJEsqYEU6zfiC9O+LCeqsulmy
 Vteg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787603922; x=1788208722;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=raF7y7IF+ob+Y5n6rCm1SnImd70Glm9VI9f/jhLtrzc=;
 b=Mi6sAb66/sfqyKqqECPKp1BuaKtKie59lt7eG8ufmYJGCl1My7iTtdd8njQNESnajf
 jH4PbzdQTEa3HpKcQUq77KCks7yAfxqM8pLH07gw8njPrTCx7PRBI1788buiYdR+6TiP
 QsKtuJVFeo6Ld8lBnEwVXNowMCUNwi/NbLq+s4U9h3WgjMTYo6aOBJygBzFIx0qVItse
 JSITywQCUHNDntOYgF4wT4Q+AKTr0d6b0rLq/1uPAzTo/VfnrU7Wpx/JJ2sfiZeigTX1
 vTb9AkQTC7NVjFkQm+23MK22a7BTuPisXpWiaLmOexNG+tiJFhL4zqFWnu4D1lnqS97v
 LXiQ==
X-Gm-Message-State: AFuF++mCJGbFR755obWV1icRLhNvOj2BgV76axwtJESlgmewRFm4lJSN
 NQau3poVgpcPEPNsjUX+DFxdWqFvlVX7pCsUaQW+1tyCrQ/BSznF+PmyEVucr15UP1E=
X-Gm-Gg: AR+sD12snv7/z7csZ/15tu5guArAaxI1EZVpqzJAXwtg+HBhQs6u/7vZfH2ZAjFXFYJ
 KQak0gp7s/pFGbME9qnyAH0duf3NyiJC02fxTnOrTd6KC+i8lstNLLc1G7hPSJ0XD9TF+qdmDPk
 1FYKbcDm9UR+p1mESoKsKzqUn56zNVu84RjuFXDxk+As1K0vgoqZI9mVYDiBb2QvMJ5uhOfbnnD
 H1I1XnqbJn9XkRm1PJbSjdmpiPwDydo2o8eIXXqETuj5wkfoWy7M+BemG3LADNd9HDYacBsiMYr
 6Fa4fF5MCJ+u9/AsCiF8iIYoT7kJHiUPhF3foID7JBhg/Z7X01aqzZ6WdT50clsc0oG6g4MQ1kE
 vtCVV+UqVzkeMz8xE5OjBVzdQ2v8ZzlPhNLUzvpMoVOUoBBQAzz3UO+FdbWSOaVSyjN6s6JS/eZ
 LYEdh1ksVOqHlVz181hTC9o8c/TKvPwroVmigVOo8fysqQrOktseqaNOGcoU2FuplFwvq8cNbNj
 H/MebCHU1r4nIQA/ayNl41rrPGkjQ==
X-Received: by 2002:a05:6a20:e211:b0:3b4:605c:2163 with SMTP id
 adf61e73a8af0-3cd4b9aaa10mr32152869637.4.1787603922283; 
 Mon, 24 Aug 2026 13:38:42 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327f9236166sm28926471eec.28.2026.08.24.13.38.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 13:38:42 -0700 (PDT)
Date: Mon, 24 Aug 2026 13:38:27 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gagandeep Singh <g.singh@nxp.com>
Cc: dev@dpdk.org, hemant.agrawal@nxp.com
Subject: Re: [PATCH v12 00/15] et/enetc: add new features for ENETC4 on i.MX95
Message-ID: <20260824133827.55ac331d@phoenix.local>
In-Reply-To: <20260821055643.1359277-1-g.singh@nxp.com>
References: <20260819053415.645865-1-g.singh@nxp.com>
 <20260821055643.1359277-1-g.singh@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Fri, 21 Aug 2026 11:26:28 +0530
Gagandeep Singh <g.singh@nxp.com> wrote:

> V12-Changes:
>  - Fixed documentation for:
>    - missing double quotes for enetc4_txq_prior
>    - In accurate comment related to secondary process burst functions.
>    - Added a note related to LRO and its BD size chosen.
>  - Fixed secondary process burst functions selection.
>  - Removed "Unicast MAC filter" from vf, but comment regarding "RSS
>    hash" is false positive as or RSS hash, the only mandatory
>    requirement is `[provides] rte_eth_dev_info: flow_type_rss_offloads
>    , which the VF sets in enetc4_vf_dev_infos_get
>    (`dev_info->flow_type_rss_offloads = ENETC_RSS_OFFLOAD_ALL`).
>  - Fixed lro and scattered_rx configuration by enabling only after
>    rsc_enable branch.

Applied to net-next
