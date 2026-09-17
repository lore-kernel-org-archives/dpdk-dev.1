Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D00C88E72
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 16:18:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 847D842ED5;
	Thu, 17 Sep 2026 18:18:41 +0200 (CEST)
Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com
 [74.125.228.40]) by mails.dpdk.org (Postfix) with ESMTP id E54F142796
 for <dev@dpdk.org>; Thu, 17 Sep 2026 18:18:40 +0200 (CEST)
Received: by mail-pz2-f40.google.com with SMTP id
 41be03b00d2f7-cc5256c2a4bso463090a12.1
 for <dev@dpdk.org>; Thu, 17 Sep 2026 09:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789661920;
 x=1790266720; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jL2Tjt7ReSEq111sLkEN02ohRs0QNSDdElJYjf7XE0s=;
 b=f6Hq0dZgELv7sdJ84g/qKI4cFYJ+JzU33XP34UUs7+/2lk8AFLpr7wmX8kj6L4w3AA
 C5RbNIjlrRjHX/MzsRI9YlXvn4jMKjGW6tK8e+cUmwgjUvk/S7SFgmKvgbMvcthrTftC
 IJ0UUyWjwzfvBAji8/mLU+DzmWQuNIpTl/f2sPKn0LTDflBsHKzIT5wXEBZHKwI1ZptR
 kuanSNPiDmLScaChK1/ju48Qzw2/XEzc2gaEsbH3MPuYbKCbSFw5AMkbRTI6ZLhFbNKd
 TR0r/DCE9Y4E7UXDwnx+Jfdk/2i1RB0472czSC8cb0e8vAClfNN5okOXoZ0gLKlzEte8
 QORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789661920; x=1790266720;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jL2Tjt7ReSEq111sLkEN02ohRs0QNSDdElJYjf7XE0s=;
 b=hZyGvOVNwHVzQx8axH1CILDT1Rpg6F142RQXF12eoLE+0OU20ge0A6jwOB20uDM/qQ
 oW5AXrpTpKZE3dfleWoQUVPHZbVZLBe9nYfxvQZAJrmQ8vSGBukDqcHf1pbFzcYkTUWT
 pK4RMoARf/3uLtX+AthJnwHxmu2A40a9dGGKeLaa4KyygziwuVt+2MwfF/Wrp/+EznXY
 4wyKM2qyGq70OqRYQlyBQZfXLq9ajSqBaxKrb/TlKtWHSxoUII/zC80K+segW/FTU9+S
 ZBeGMr3Dd/zapwmrG22akWZw4zSv9AIiiMpFIMpiZm+2dWuQN6Cx1vFlzTefSLfUwFuY
 gpmg==
X-Gm-Message-State: AFuF++kqiKyr5ZxerUJ1e4gBPE3mTXgVVoGqBAETvR9shz/T0et0lGmI
 LA7sJERO5fJxULv+ERKQYt+6rhOpmnns/aSMRv14/Fn7cufzqgYEdvpwBkmyMdPc268=
X-Gm-Gg: AYBFou3ine88O9cXMcT+J1DEkx0Lt5/V+6iHXDA+AKQXYbL5720pKjjQTVuSRC2Ijm/
 AEL+sSxiDhVo5DaTK/AUKEmXkDM0ofqL+6C03ZYyIFE4tZCOPwSPyqwS7orMKjo8zpwiTsDqYJv
 ysCM6oX2m0+xTCQJZczoD/psTZRGjAThmYM51QdW9GXS8fyjqoRF+OV+PCTwI14CXJHgqBo2Et7
 dMWuLps9vVichKlLdIxSg5mjxBm9nwCOUG4Nc64Edx+nqOjJuo0tEkORrcJyEPgJdm2s6Dbj26Z
 3Mq7+LOBr0keFuZV4Znwyve0j4jTHEsVZtmBcRUjSAEqOa6n9SDRTI4Y+yh5uJ/ZXTLqrm0yKtg
 0a1XPRdm8yEj9bs5vZtAf7pXE8DOMun6PdNWv7T+VJ2vgqsv8E4IxPmkc1ol2rKb/TEovn3foSB
 p11u3dYu4B44NDRKvynnPEDTejgAKK5GFKUXdSLbUODYNBKkm9hkSlLQG4d2AzYPaceDnsoXkFH
 +7MvgZaXVXk0ZAibkn80TkdIGogPQ140d4zzPQA2w==
X-Received: by 2002:a17:90b:3d47:b0:395:5f43:4ec4 with SMTP id
 98e67ed59e1d1-39e1e26a235mr15579276a91.0.1789661919962; 
 Thu, 17 Sep 2026 09:18:39 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e3c06423esm4824952a91.15.2026.09.17.09.18.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 09:18:39 -0700 (PDT)
Date: Thu, 17 Sep 2026 09:16:15 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Rahul Bhansali <rbhansali@marvell.com>
Cc: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar
 K <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha
 Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>,
 <jerinj@marvell.com>, Rakesh Kudurumalla <rkudurumalla@marvell.com>
Subject: Re: [PATCH 08/14] net/cnxk: resolve mbuf from CPT CQ format in SSO
 work cb
Message-ID: <20260917091615.4e1cf74b@phoenix.local>
In-Reply-To: <20260917071016.2366467-8-rbhansali@marvell.com>
References: <20260917071016.2366467-1-rbhansali@marvell.com>
 <20260917071016.2366467-8-rbhansali@marvell.com>
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

On Thu, 17 Sep 2026 12:40:10 +0530
Rahul Bhansali <rbhansali@marvell.com> wrote:

> From: Rakesh Kudurumalla <rkudurumalla@marvell.com>
> 
> When handling NIX inline CPT CQ events (type < NIX_INL_SSO), derive the
> mbuf from the completion queue word layout using fmt bits: WQE_PTR_CPTR
> uses w1.esn; CPTR_WQE_PTR uses w3.comp_ptr shifted left by 3 for the byte
> address. Pass the mbuf into cn20k_eth_sec_post_event instead of NULL.
> Drop RTE_SET_USED(args) since args is consumed by post_event.
> 
> Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>
> Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
> ---


Patch 8/14 net/cnxk: resolve mbuf from CPT CQ format in SSO work cb
------------------------------------------------------------------
Error: wrong mbuf address for inbound events.
  mbuf = (struct rte_mbuf *)(uintptr_t)gw[1];
- gw[1] is the raw WQE pointer; patch 7 only masks the low 3 bits.
- Outbound is correct: the Tx path stores (uintptr_t)m | 1 in CPT
  word 3.
- For inbound, the same function's RTE_EVENT_TYPE_ETHDEV case uses
    gw[1] - sizeof(struct rte_mbuf)
- So cn20k_eth_sec_post_event() reads *rte_security_dynfield(mbuf)
  from the wrong address.
Subtract sizeof(struct rte_mbuf) for NIX_INL_INB_CPT_CQ.

Warning: WQE_PTR_ANTI_REPLAY events are dropped.
- eth_dev stays NULL.
- post_event() builds desc and skips rte_eth_dev_callback_process()
  because of "if (eth_dev)".
- It returns false, so nothing is freed either.
Resolve the port for this format, or do not dispatch it.

Warning: the commit log does not match the code. It says WQE_PTR_CPTR
takes the mbuf from w1.esn and CPTR_WQE_PTR from w3.comp_ptr "shifted
left by 3". The code (patch 7) is the other way round, and masks
instead of shifting:
  WQE_PTR_CPTR:  wqe = w3.comp_ptr & ~7
  CPTR_WQE_PTR:  wqe = w1.esn & ~7
That derivation lives in patch 7, not here.

Info: post_event() log messages still say "Outbound error" for
inbound events.
