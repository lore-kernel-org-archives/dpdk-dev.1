Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307D3CD4F26
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Jun 2026 17:22:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1FD084027C;
	Fri, 19 Jun 2026 19:22:06 +0200 (CEST)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180]) by mails.dpdk.org (Postfix) with ESMTP id AFA3140279
 for <dev@dpdk.org>; Fri, 19 Jun 2026 19:22:04 +0200 (CEST)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-30bf132969bso2807846eec.0
 for <dev@dpdk.org>; Fri, 19 Jun 2026 10:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781889723;
 x=1782494523; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
 :reply-to; bh=1GIwK9H3MO2ke9VN6JRRSsVwjz+6ufHOPKXZhQOAc7k=;
 b=zYbO3jo9McTtQbwcBF+PJcVjzPgsYbe91BeFCf2RCwHy02JeCZVGwIg8KGaaP5Maif
 eHA9YrqV9tHzoiPygdAofh25TeYxhM93EQqXCs4tbQzgKGZD9MkVgijbmMW4jiGTKTG0
 MJLIGW+kEmXXWqrVv5MagBJwYAghz3fWMwyegK9KgAB9xXEDkuUJD8tIws7y1GP0Ndcd
 IVhbmmznrQmBYItd8QxK9BAd9JuMx/VjovUPMCq6SQAWfk3tVWK32ZCzPrUZadzVVBn6
 AXAbnWgatgqEAzCSGJTJnbcoVm1YD6U4TagqqqcxYV+Hfv7K76+zrH3G8lmmN7NCYhjr
 EajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781889723; x=1782494523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:to:from:date:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1GIwK9H3MO2ke9VN6JRRSsVwjz+6ufHOPKXZhQOAc7k=;
 b=qj2Byv07dqsM0+hB7qbxtlF8kkKxOmUvGHrtPoADnqlrDH8z6SeFdiTU6nF/qAsCMg
 29nzw1bc5HEUD1wuCe+tsmKctt7XKERt2Ogx//G4GO/4lpwG5/CplOtu8rtnbxIJpOo+
 LGMOQaLK1u9zVzqYQ6blc7kn6ncSeX0b3sVkrJSKXGqzXShVJNLfI/KyyqKjABdZkOoZ
 HqVamMCvrltbhg+CIlg9F02tZj8S/h9/A4LoOHzrtLdisM3P2GbFSI6CyM0bzITHATR6
 QPF9KjIHWA2TIaVFFA7Gu4zjcWWaVyK/5b4/Rf284gG10kvZUHdJLYLMgtPAIXVFbvue
 z3BA==
X-Gm-Message-State: AOJu0YxM3+B0I9dKzAssge3NaHHRk7+rpWY9Xl4V4+etgC1udEDc5g05
 Ulwz2NyAxcr67bWaaUtnWYxOLKic1oFCnjGSkJ00CAcqYtjHnxlcHwUMvpwm4XPzpS/rQ79FTv5
 Q7r7n
X-Gm-Gg: AfdE7ckOwJJnyLD4+BQ5OgIOti7Vwr/z+ByDPZbxiUKdq3L7/0KQ6kkJuMgZh6Zpscj
 gFIMe24HF5sH4VUcchsfB4x3BEJH1O4kzX5XOcLqxRRvpDOrVTC41KDsqqATudNDc2PHs1891Ee
 DTFsqIuerVmZQpVSgVcSG4xLVCSmYfAUGUkLGC0kyd0efbzze8XML6PxO8H2lI/GqeVZ8WxzWYw
 wsF2n1oYWAvzLEfjBtg+qMGcm+GLSRoEnjmHPH2sxN7OYxnzP9LrROJlrqQJmtOe53AFbN2CzDu
 w+82OmR/rEYQiHgSwGwBLw+AtcIte/3IoW4RQ+sCndm9zI3FNIrmLXRXgFTeY7N8evSqDcsKA7f
 QsTV05I3QE8v696+vPKtjXtib+ar+6aKjj9KVv+JCkFM5aHmtaJx7uFLPTxvJnr+Gqf+Kbhh3mQ
 NZRQm8Qb4bPRypC1ZaggXFmtGMhDleq9QrEfm1oknrzpa5QrHluzHauw==
X-Received: by 2002:a05:7022:1b0f:b0:138:62a:270e with SMTP id
 a92af1059eb24-139a20537b4mr2629744c88.11.1781889723051; 
 Fri, 19 Jun 2026 10:22:03 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139adcc5f14sm3716c88.6.2026.06.19.10.22.02
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 10:22:02 -0700 (PDT)
Date: Fri, 19 Jun 2026 10:22:00 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Subject: Re: [PATCH v2 0/4] net/bond: fixes and cleanup
Message-ID: <20260619102200.01f00190@phoenix.local>
In-Reply-To: <20260529000157.235931-1-stephen@networkplumber.org>
References: <20260417165530.653328-1-stephen@networkplumber.org>
 <20260529000157.235931-1-stephen@networkplumber.org>
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

On Thu, 28 May 2026 16:59:12 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> Automated analysis of the bonding found a few minor things.
> The bug fix is in patch 3 for secondary process crash does rx/tx. 
> 
> The cleanups are in handling of 8023ad mode setting
> and the logging macros.
> 
> v2 - feedback about the mode setting and log messages
> 
> Stephen Hemminger (4):
>   net/bonding: make 8023ad enable function void
>   net/bonding: check mode before setting dedicated queues
>   net/bonding: prevent crash on Rx/Tx from secondary process
>   net/bonding: remove redundant function names from log
> 
>  drivers/net/bonding/eth_bond_8023ad_private.h | 17 +----
>  drivers/net/bonding/rte_eth_bond_8023ad.c     | 16 ++--
>  drivers/net/bonding/rte_eth_bond_api.c        |  4 +-
>  drivers/net/bonding/rte_eth_bond_pmd.c        | 73 ++++++++++++++-----
>  4 files changed, 67 insertions(+), 43 deletions(-)
> 

Applied to net-next, took Bruce's suggestion to split the first patch.
