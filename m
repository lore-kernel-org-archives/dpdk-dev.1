Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F56CA0EE0
	for <dpdk-dev@archiver.kernel.org>; Wed, 13 Aug 2025 16:10:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D317640ED4;
	Wed, 13 Aug 2025 18:10:22 +0200 (CEST)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48]) by mails.dpdk.org (Postfix) with ESMTP id 6D30A40657
 for <dev@dpdk.org>; Wed, 13 Aug 2025 18:10:21 +0200 (CEST)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-45a1abf5466so586815e9.0
 for <dev@dpdk.org>; Wed, 13 Aug 2025 09:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755101421;
 x=1755706221; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HUvWXWLJmGbXmGv7jtN7X/0xpbSBDKHTnMbHyXnzgcE=;
 b=kA21ARaExwQwNHNAxQBfGCHPMqLw4Imw49IsTYvaR1EfzX9L+W29v1PyF/H47ZNwSs
 jBkkhQ1Pn4b3LTqYnLrmTNTc+AE0rzY27lR7XxA3rayHKtuoDZnNxaCLl8jBOU4mykYf
 0lUs3QDWwYNvy4A3RYjmDBzPTmFqkAGLJzkw3UOPtGd5uq6PeEX+Ujk0RbD49JRqcYy+
 3L6f3Iz1vFFNygZHbfEArNe6+o5uvkysY22pGVaopa8HFu8uNihZQCHK26imIiAgdLge
 7qkMeV6WubNF5ORS5dGw2UkdvCtwAm65NR9ckID2lkReYenzMsLsEwg2T7lXC6RjGTG/
 YDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755101421; x=1755706221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HUvWXWLJmGbXmGv7jtN7X/0xpbSBDKHTnMbHyXnzgcE=;
 b=B9kcakPVDAtO7fsGmY/Vbbf+c3GDRpxPcQ4Axv92ncT3XMFouMb1VwYVafg1VJ2CKB
 3KCmVFuBCEWcImg5fFEPPku7E9FMXe/qsfljaLBLSYenBFm84KB6oTxsLme79HRSehtS
 qAx9SC3OhhEXuIishvFm0b37Y6J+0ErK6N1AOOTRY9vo7fD0cbz6aQACRfXMvgM7gX7q
 nWJU0iwvYvto4pQ8OVKRagzXiQ6Xys584RzSVOoluaILcYtRpiuFBRTx9c2bZ034uLqY
 QAr0zWh6RRG2JhDYSOyBkzcrF0aJWswbQIfg5Iq/AIyNxL19b8tek/+gyYx8dfekQELU
 Kw0Q==
X-Gm-Message-State: AOJu0YwY4RF4e7sxuVXE6+sgJu6XTv143EAhXOcL3xeE/HWxP/bIX72t
 bCYtGmW4YKMVk/RZQnAZjYF+Kaqq2rRc1vDRBmwxWEpqTMj9yRVYRpz8KEOwAaTT+Pk=
X-Gm-Gg: ASbGncv73lYmhm/tnDnxBZsHQFxMSFjUo5WV0Y7Z3KYK/fxQpWlkRD/cm7Hgt9mx91K
 sriReyOhdfQm/PPld4ZhPe6DvJL+ewvzEd8pKa84MvNRWddtFKMvhrhg5amW7qUOIf4xspNymJa
 2s0ieaqHBH2j3M5zZZZDAlLbrI8MspfhEOxTYm2P4R+FE7JuIECLn6S7g2xwZRa3J0sH0coFh6y
 /RLfLIEmRLIjB8fDJdVpoadUfRJhhD/wK3cuxUFNFZi8dUDW+5ZZwLw57CuvMgl93sF24QyPbxJ
 6L/a22WpUifKcGFyfiLGshu0pUHgIyFh+VK4XeC0RFXcpZUCSZ0RRoNF0wLYFRjISDvwIA8EbEt
 QZ76xKYo/ghn1ngLI/X+8ghFFvN8cNYpc42xHUsKkz3+x7VHFfvDZrfV2/J9ZfebCuiPh4KB8/m
 s=
X-Google-Smtp-Source: AGHT+IGjYVNoH9/mLAZwy327m1jwu4DNEftUvhSYO4pmKTcIH5xc12r4Xj2Xf3tuDqHB+lQyeYHuKA==
X-Received: by 2002:a05:600c:a10c:b0:459:d577:bd24 with SMTP id
 5b1f17b1804b1-45a1acf9e03mr981485e9.7.1755101420825; 
 Wed, 13 Aug 2025 09:10:20 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a1a50a446sm7638175e9.2.2025.08.13.09.10.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Aug 2025 09:10:20 -0700 (PDT)
Date: Wed, 13 Aug 2025 09:10:15 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: huangdengdui <huangdengdui@huawei.com>
Cc: <dev@dpdk.org>, <mb@smartsharesystems.com>, <david.marchand@redhat.com>,
 <roretzla@linux.microsoft.com>, <lihuisong@huawei.com>,
 <fengchengwen@huawei.com>, <liuyonglong@huawei.com>
Subject: Re: [PATCH v5] eal: fix uncheck lcore role
Message-ID: <20250813091015.67840747@hermes.local>
In-Reply-To: <16cd59c0-15ba-441c-ace6-8741c7586a3a@huawei.com>
References: <20250724112551.2502389-1-huangdengdui@huawei.com>
 <20250807024936.2039379-1-huangdengdui@huawei.com>
 <20250806201545.514def16@hermes.local>
 <16cd59c0-15ba-441c-ace6-8741c7586a3a@huawei.com>
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

On Thu, 7 Aug 2025 11:57:31 +0800
huangdengdui <huangdengdui@huawei.com> wrote:

> On 2025/8/7 11:15, Stephen Hemminger wrote:
> > On Thu, 7 Aug 2025 10:49:36 +0800
> > Dengdui Huang <huangdengdui@huawei.com> wrote:
> >   
> >> diff --git a/lib/eal/common/eal_common_launch.c b/lib/eal/common/eal_common_launch.c
> >> index a7deac6ecd..be7226e4b6 100644
> >> --- a/lib/eal/common/eal_common_launch.c
> >> +++ b/lib/eal/common/eal_common_launch.c
> >> @@ -36,8 +36,15 @@ RTE_EXPORT_SYMBOL(rte_eal_remote_launch)
> >>  int
> >>  rte_eal_remote_launch(lcore_function_t *f, void *arg, unsigned int worker_id)
> >>  {
> >> +	enum rte_lcore_role_t role;
> >>  	int rc = -EBUSY;
> >>  
> >> +	role = lcore_config[worker_id].core_role;
> >> +	if (role != ROLE_RTE && role != ROLE_SERVICE) {
> >> +		rc = -EINVAL;
> >> +		goto finish;
> >> +	}  
> > 
> > worker_id could be any value, if it was out of the range of the array
> > you would end up reading junk.  
> 
> The lcore should not exceed the RTE_MAX_LCORE range, which should be a common understanding everyone.
> I believe checking it in the code is redundant, updating the documentation be a better solution.

It should be in documentation, but this an exposed API, and all non-datapath API's must
check arguments.

> Moreover, in some interfaces[1], if the lore exceeds the RTE_MAX_LCORE range, it is difficult to determine what value should be returned.

Invalid same as your other checks. or ERANGE?

> 
> [1] https://elixir.bootlin.com/dpdk/v25.07/source/lib/eal/include/rte_launch.h#L112

