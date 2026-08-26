Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF45C5DF97
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Aug 2026 20:50:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E63D402F2;
	Wed, 26 Aug 2026 22:50:33 +0200 (CEST)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53]) by mails.dpdk.org (Postfix) with ESMTP id DFA9E40264
 for <dev@dpdk.org>; Wed, 26 Aug 2026 22:50:31 +0200 (CEST)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-38dfe910e9dso1146274a91.3
 for <dev@dpdk.org>; Wed, 26 Aug 2026 13:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787777431;
 x=1788382231; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=v3KV989YTMPsSXOgBe5dbevShZB0PmYvigc8Jd61Cds=;
 b=B73LqBWkCQ161AasxipQSXN1q4Id1XxFzlV7uIEY+uYOh4FJmoyta0+3UYfJDKw4wZ
 ZMG4D36Nsq3R7cyPzn6mHrYBI0dZnBBoukN/qTh4Up86tMJzqTyuYmcYGVicBjjuBU0b
 3gHNnb2bhOPZMovBidNunepwULRn7TAPFMtkLw9/jg0cVBqzFBbvR8fO15S70vsYopTh
 UI2tbEDLb+2WJ7fArS6+Ez+BH78wnlmbm6psgefmCg7ps9eCGHnDQwe0vsgD8t6GYzAL
 Y0Iq2/IdIL/QHumh+f95yRhT2HwKy2SL0NXJa+XolbcC2p81+6sNIWx/8kdntWS/WWah
 zX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787777431; x=1788382231;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=v3KV989YTMPsSXOgBe5dbevShZB0PmYvigc8Jd61Cds=;
 b=lRGT7pdk754UwdnhvQ+llaeHyMRJO1UVkRxdXba+jif4S783M1Oc6beKv+r3kwpwYH
 NViqvZO50fvcodlM0kBA0/6V0U561tfIm9Gqn07LCt7a6XsVHaPuArpT4lk0d7jG6QFI
 3psT1gIrI1TeSvQbe3KBqWxdwNsPO7mN3EW3kd3jrXWy0QYcva5AXpn99CArsS07llf4
 dSE2k9+ZhGSUfEKYDdV6I+3mu23zVMIfAwLsJGwz4tD0yYtnMw/2fG/wC/L67bhG+TWG
 nb39GOi0TX3PVi+uWlWIFF3mPGh8V2OqbUklOtldzFn+WKXnkb1G5tiVMcVPuAIK5Su/
 q7vA==
X-Gm-Message-State: AFuF++miT7rT83A2sJZBcFzuBkAu+TgEzwPnLwCcTvUmBDg15ODow29q
 XMvFx0tTU+d/r+gEomqtq+EdJaG6DY+e2vMJDZaPrT0KZhSwLArpJnaZ7r6xd9pS+Qn977CXMt1
 Bgp9W
X-Gm-Gg: AR+sD13qVbEzOLiQdcXfQpaPBqy9rUnX2sDRT+pIZ4ce4zqs5v2HaAIlQsxlYYsZRes
 iQANneYcy25zHwL07izjxG/TQ3hjVwWh2AAavcjBtrMLOppCsuKCWR79GaI8n8C5yvMccxQfHuQ
 53LgLdZUgSdIfX3d8UIWyE/0POkdjwH+bgFEc9TG10763vx4EDehmau8lZycdvEoHgHnE0h5sB4
 8HL/7SHhFNzRD03us2EC3n8aTQ72dxsudkJ6tAhZUmuiuRQmBjNWcUAtiujFcCUOs36g14NMNJl
 rnfOrE6Evrhen+IDxANZdBnhF4meTRAGYvpem39Q53hwXaDoY+JVF3v1OM5uxbLPqQIGixWVhFh
 xVlembhs9swMc5qgG40GgP6ENBRc2RBXHM5LneXy7Pcr3W7Hfyv2FULFsthTsvoS2VwoK2DBleR
 AHTOt7oKIRnMl9jIt4sUN7xXbjNz/lAAXG+7BnjssrhW2wf1i5ZzJJpBOhBT6qoMChWhvVp+zXh
 vsHHR303BjAYOb3MCOVqBAbEwxbYA==
X-Received: by 2002:a17:90b:2885:b0:380:71eb:4014 with SMTP id
 98e67ed59e1d1-3966d5c1a78mr20720160a91.15.1787777431052; 
 Wed, 26 Aug 2026 13:50:31 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39645d993d1sm9399375a91.15.2026.08.26.13.50.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 13:50:30 -0700 (PDT)
Date: Wed, 26 Aug 2026 13:27:36 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: William Bland <blandwwa@gmail.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 3/4] net: add VLAN insert function with a TPID argument
Message-ID: <20260826132736.31f77eda@phoenix.local>
In-Reply-To: <20260826173842.1298754-3-blandwwa@gmail.com>
References: <20260826173842.1298754-1-blandwwa@gmail.com>
 <20260826173842.1298754-3-blandwwa@gmail.com>
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

On Wed, 26 Aug 2026 13:38:40 -0400
William Bland <blandwwa@gmail.com> wrote:

> rte_vlan_insert() hardcodes EtherType 0x8100 (802.1Q). This is wrong
> when reinserting a stripped tag whose original TPID was 0x88a8 (802.1ad
> QinQ).
> 
> Add rte_vlan_insert_tpid() which takes an explicit tpid parameter, and
> rewrite rte_vlan_insert() as a wrapper that passes RTE_ETHER_TYPE_VLAN.
> 
> Signed-off-by: William Bland <blandwwa@gmail.com>
> ---

Applied to next-net.
