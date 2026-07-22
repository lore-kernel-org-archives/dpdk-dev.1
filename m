Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0E3C44536
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Jul 2026 18:20:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 887A740270;
	Wed, 22 Jul 2026 20:20:32 +0200 (CEST)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id AE3824014F
 for <dev@dpdk.org>; Wed, 22 Jul 2026 20:20:31 +0200 (CEST)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2cab973140bso159245665ad.3
 for <dev@dpdk.org>; Wed, 22 Jul 2026 11:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1784744430;
 x=1785349230; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=I2Otp4yzQyIa9Da40/50Bi3Zly69E39uu0W63W31MDQ=;
 b=sNIawVr8PT0KGfAUctDaKvClMoyWYUxiyMjCgHKte3UHwV26zBOven2AYp3BkBRqIh
 kGsj1sWKi9iRYNjwIzJFr9Ju9usdYk9tD9X+gAXRU9Xnz/F7hATGhQE5ENBi8kaINCnX
 6LFd7GuM6aG0/UH1cSGLgdHU2i0Gpvls7R3KMlQ4rILJNtvtHyTxbtr7o5wxH3E77ZpW
 8ev4UUv0C6IvxD0M2lyolLSCznOhxS/+F9Od/kfoR+xpG/P5sLINkDyUnRxVB+juQUV+
 wrmZ0CHR5ZN5C4SFwXSqi6nXpvupKkmLeubNf8tIxQi08EuTyYQaJBp3iM/AXkvzsOjD
 FNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784744430; x=1785349230;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=I2Otp4yzQyIa9Da40/50Bi3Zly69E39uu0W63W31MDQ=;
 b=N2F9eKRcExaJ2mzxEH39nt4cwzDj2qGsd4rRPlAy8GWa6zvWbOTsABwfMR8+9P+miq
 mEB6fijdFbo/KoDPkZWapRcTLmejbHXvi33W4IdyH1GJ2ckZe5ULjoHTtzA8riAHYzos
 TTn0lPmfGiCZHM+dCGuunCX/VpreEHQL1zztiJ4yR9oGK2flHg5G7xxkyKDwJ2A3ux3+
 VcVC3k5y8wlEYa1w5wjnGymkErrOkXk5YD5kOAurY5csKKdMLc8kZnMp+LmLskx91gfr
 hRWxGXKxXT1MmhBvjtTh+bRu1ZoK+p61h+R311gWgC8VeH+pEcVWeLOR8qrDJCGeMOm0
 oT5g==
X-Forwarded-Encrypted: i=1;
 AHgh+RovtW7hu8z4VqKnrbyHRK8kpVV74RagxXm6GdvylOrBCjds6zmIO+LbUV36gxiy5OuoKVA=@dpdk.org
X-Gm-Message-State: AOJu0YxqRrDEdZ+ivg9eFWqu76UOG8w3XoZ0I35UDAt6CRO3bcscirpp
 DU1v0Gn7T4GtGZJd4BvTVgdbx4acU/bIMg6MstNyNkRz+IbAK82DjE318OFi1jQE5fo=
X-Gm-Gg: AR+sD1168IV1q00z4tKfd0xk5mf3bKg6A6GDymQ5YDsgw3jLU5BO98nRWRFhcwlB62m
 Jfu+VYyVK0ucMdQ4GT9qX5AJZ0Mn5uq8npjvK+/LlWJ5zHRNHqzF5HqebE+M+D1cYqwRVkaXR4b
 PNWzEVNG6Af2RD2F0ZKRlxzZW1G3vIdOvpMcjF7gUq1AgQ40WRHpRnZb2wNTvwIAh40nwum7e5m
 ZlC/q0DlTSyqCC1ufa4y2w4kdwo/p9Neb2QQcUCM9KYMoOAEnxXfz5HcxdRBilT7Eeu2Ezj6e/d
 d6OwsOC1luSJl3kexMZiy6Jfrt+wyxQ+t0ZOEsth/D/IX1ZYhuXUujaXuzGit3ifI46eY3OPOlB
 kpSOBZYn0/mA996y13sbjzu+8liAIF3M6hs+SgdX7LBaLMqdovE2czUF3fVzwJQALyYjI0X8tmc
 th+6/gXEtWFz2naDivUbJNNl8RZoDmAjbfKnneR8t0ro8=
X-Received: by 2002:a17:902:cf0f:b0:2ce:93a3:c16c with SMTP id
 d9443c01a7336-2cfa6b7c22cmr182655ad.12.1784744430565; 
 Wed, 22 Jul 2026 11:20:30 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147dc1e3d9sm9805480eec.5.2026.07.22.11.20.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 11:20:30 -0700 (PDT)
Date: Wed, 22 Jul 2026 11:20:26 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Evgeny Sokolov <Evgeny.Sokolov@infotecs.ru>
Cc: Thomas Monjalon <thomas@monjalon.net>, Chas Williams <3chas3@gmail.com>,
 "Min Hu (Connor)" <humin29@huawei.com>, Declan Doherty
 <declan.doherty@intel.com>, <dev@dpdk.org>, <stable@dpdk.org>,
 <chas3@att.com>
Subject: Re: [PATCH] net/bonding: fix the log MAC address restore failure
Message-ID: <20260722112026.180bf024@phoenix.local>
In-Reply-To: <20260629135841.1181247-1-Evgeny.Sokolov@infotecs.ru>
References: <20260629135841.1181247-1-Evgeny.Sokolov@infotecs.ru>
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

On Mon, 29 Jun 2026 13:58:40 +0000
Evgeny Sokolov <Evgeny.Sokolov@infotecs.ru> wrote:

> Log an error when rte_eth_dev_default_mac_addr_set() fails while
> restoring the default MAC address of a member device removed from a
> bonding device.
> This improves visibility of failures without changing the existing
> behavior.
> 
> Fixes: aa7791ba8de0 ("net/bonding: fix setting slave MAC addresses")
> Cc: chas3@att.com
> 
> Signed-off-by: Evgeny Sokolov <Evgeny.Sokolov@infotecs.ru>
> Cc: stable@dpdk.org
> ---

This patch is technically correct, and I have no issues with the code itself.

However, the submitter's mail domain (infotecs.ru) belongs to JSC
InfoTeCS, which is on the EU consolidated sanctions list. Whether a
contribution from a sanctioned entity can be accepted is a legal
question, and not one a maintainer has the authority to decide.

Holding off on merging this patch until there is direction from LF
legal and/or the DPDK governing board.
