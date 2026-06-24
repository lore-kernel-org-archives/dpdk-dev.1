Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F04CDB479
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 01:44:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 28C0840666;
	Wed, 24 Jun 2026 03:44:16 +0200 (CEST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com
 [209.85.208.181])
 by mails.dpdk.org (Postfix) with ESMTP id 5AF8340667
 for <dev@dpdk.org>; Wed, 24 Jun 2026 03:44:15 +0200 (CEST)
Received: by mail-lj1-f181.google.com with SMTP id
 38308e7fff4ca-39677c80386so4342881fa.3
 for <dev@dpdk.org>; Tue, 23 Jun 2026 18:44:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782265455; cv=none;
 d=google.com; s=arc-20240605;
 b=GmDlI4wyc7MNDqScRqFbZrUeKXYH99b7CnI0dA5G80qzZpg7Yr23F+z+GhWBtoT5AC
 MuzajR3oLkpCsWTYo0ITWqDM5Ko9FFiwU0sa18CDFEnYcwH/vcCYxKoz2qM4CN8JPKOi
 8CI3Z+92sJtw7pyCW3R0fzanDiBaCFURq6B1HUTKQz9Z0T2DyoKnXqB+ycayKUYsMkoK
 0H77PEpY/oBrkMuI2V0C6JjkoTabRTp1/R8vW8QXZaEzklQQKgy862/1wCL5QAWglPKe
 1rDgnpDOZHyM+MaB8RpVhMKSmKJNbpfrcC36Fzx0cMsSY6NBLlZBMFtpoZrWyEsB7juS
 0VfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xQsshlA/sXO5vdNfKtJVcIIchpUVESeVSAzjSSnRlWI=;
 fh=wcxrwi07Ikq8z1D2SauuLOgtYR4V0mxovkR6o2KV9QA=;
 b=EZlI1qSDbBrS+b8HX07W2nBd5M9GsflziDhPeU2Y5TkoNKkz9Y/VHQN75cDhDEhp6O
 QFeMmEQsLv3zeSFH7G7tLlrYGhkVD+SfCcJ9KbQIpYiN3pMusENA16p7erKGhkiOYnG5
 DSVqLwYGRumsEIpG0xxXOhhPATXWQZLfS2lx+tlvx6PQkyp3wwcV6ciCyEZLS+INKLyA
 dds7kJ0ulpuGX9Gt438YzOIZaGdd2zGjLBgLu1quwgIfv3/p2noE+gPrLu5Ni3KjuORx
 5CZIDKe8Glamqg3yPMdDVUU0CiYfXBkxFUu+Lwgwd6TeeHteY6KvGt9bm4pfiU6TSAvG
 ezfw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782265455; x=1782870255; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xQsshlA/sXO5vdNfKtJVcIIchpUVESeVSAzjSSnRlWI=;
 b=I6soDHgHFKytJyy2aq1sXUWKzlbz/TOSda4TDVRGGiV3iEbV6XE949ipng9JAP4Cav
 j0Sb8SlaSyyOFrrkj2a0j0yFozC3Zkf8RVH2ZrGU6FT2VEzORnLfs2+thfVy0nCj+r+F
 MDNnYupAZxTIlcf0o2dTGpHOOHKTH0Aey7LzfC6PnRVtow204HSBWqZgPC/w+Ms48rjD
 bJgPVaY/eD957JnxcVN9f75AAS8kO64OLvFgGp3pSvXfzlFxJbKfQJTcf4Q6o8ZMea5H
 08z1sCIcowJCUOXSynjUa4mWGC3aLNrkNwc1kIlZVMsnC99vAGdSNt4c1pp2CzQLMP/J
 ko/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782265455; x=1782870255;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xQsshlA/sXO5vdNfKtJVcIIchpUVESeVSAzjSSnRlWI=;
 b=J1PU4M+ZIWncHpHUiKsrKSGfUWKKKeg8jrEaT7TUJAGBqDGKzK6gBZWnWyKiMVJiQe
 RcFzfqXPFi5EvhR+1M9qtaTKNnkiIeQgkojnnVNbuHWH9ot1yhSU5T0mCq3QM5bVHmnV
 a39jvwuDhGf6pYtCklarI/NHAZuo/lW1xDAvMAILMxmpocXiX5fnhOfaHrihR1dl05zF
 kUoOhHS37HkqOdZ3tIXOG62a7FoFPtk7mD0PJCx0tZAZuXhk+9MOZtz0QWwDktpbqE/V
 Yf5/NheU3BJV5g/6b6oHtJxEnAJHylyzgXJRKhkZFunIX0YkAo0XsKD4iaTsyZaAKFFx
 n/JQ==
X-Gm-Message-State: AOJu0YwZM11/F+oRG3eomkaPZ4YrkQlO0ft1tDL/Ljsn8D9dsuWRcQgD
 BkRR4qIKeMxI4Uxgj6hg2GGNzsVRgnY1/PdGSyDUlAS9Y/cyAOZMYYBdFRmjKqRKqqA6C2Y0oZe
 wer8JGZVoVnVLctLs5XDGGa2sMGZUWIQ=
X-Gm-Gg: AfdE7cmxPvIX18nElqE13/8NPaOgXZmCFMFHTntQWTSUSH6EJuN/3RR0y0I7XoQhOD6
 fM5gIk4OP7VtsSck0e7vlx4r3Bo2Xsxx0CwghrYaHoxaoZNs8Kbo2BoNYmAIgzsiq0bjA5VYmeY
 zvT2w1JJlUfyutAkeHu3hrn0wnGlWnyBLS9XAVJSFGnhwGmaQ56Y60jnHD8XvKLMsQZjeApOJ9I
 eONvRQBZJBmok/XqnyChacpSHFv8B6ykDExAVm314L/eIKw2trI3SHWJ+4v7VNgqyZ3yraEvq+l
 ZXLtzto4RXIyoSx3i/wMXbgJ77Ae55uE4vTUek8owcApiMLSpPvTu6Pj
X-Received: by 2002:a2e:bcc4:0:b0:396:d714:af72 with SMTP id
 38308e7fff4ca-39a27e6ca3cmr14788911fa.13.1782265454379; Tue, 23 Jun 2026
 18:44:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260422183524.2012369-1-rileyf@linux.ibm.com>
In-Reply-To: <20260422183524.2012369-1-rileyf@linux.ibm.com>
From: Patrick Robb <patrickrobb1997@gmail.com>
Date: Tue, 23 Jun 2026 21:44:01 -0400
X-Gm-Features: AVVi8Cd5hADVPRquf9rpUsVRzX6Hhp1aja-XENpSuw6BgXJNA0Z9jH7e6tWEKlA
Message-ID: <CAK6DuxsnwqBPaBGybADog-7=5heh30MU4uHGUpFYH4ZjbnODbA@mail.gmail.com>
Subject: Re: [PATCH v2] dts: fix port info getter when port is not found
To: Riley Fletcher <rileyf@linux.ibm.com>
Cc: dev@dpdk.org, stable@dpdk.org, Luca.Vizzarro@arm.com
Content-Type: multipart/alternative; boundary="0000000000004dc4c90654f60398"
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

--0000000000004dc4c90654f60398
Content-Type: text/plain; charset="UTF-8"

Merged to dpdk-next-dts, thanks.

--0000000000004dc4c90654f60398
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">Merged to dpdk-next-dts, thanks.</div>

--0000000000004dc4c90654f60398--
