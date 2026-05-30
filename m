Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CC2CD6E49
	for <dpdk-dev@archiver.kernel.org>; Sat, 30 May 2026 16:38:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ABD9E4029F;
	Sat, 30 May 2026 18:38:01 +0200 (CEST)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com
 [209.85.160.175])
 by mails.dpdk.org (Postfix) with ESMTP id CDB514028C
 for <dev@dpdk.org>; Sat, 30 May 2026 18:38:00 +0200 (CEST)
Received: by mail-qt1-f175.google.com with SMTP id
 d75a77b69052e-5174a1f2d45so74851cf.3
 for <dev@dpdk.org>; Sat, 30 May 2026 09:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780159080;
 x=1780763880; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=udXduNOM86nXXnYZCshdMVHm4vEQka155OVy6Rm0rsc=;
 b=iKDbZ4vnDfLdYQDN03/RIlNOrxl8+ru1DDdKX8MIHlulfd9nE9/HwSEPV8UIs1+1jm
 4DekV7u8gKVN5vXtiQWNlRXnAagu+hfHh+2nrxmoYYPMAW/C63xGG83DOAIFa6IR4TvS
 5VWmopL6MzqwQVt4Dv1sF4GNwjzbA8ibJ1Pu0jrIx2AdJ+fbE1mo5VH/Qw6qVoqOu645
 O8z4qvinBgm+GL2r4Hhl1bLLz2OfefV3CK2uWozRh/jlF3NfrORcOR8IBlrfeLNCywCp
 fT5SAtJN2tx7yHS3qlVhcunlF75eg2w7arz2FkpE42fV0P2IURjdZhjkmR60bfBRKyil
 DpvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780159080; x=1780763880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=udXduNOM86nXXnYZCshdMVHm4vEQka155OVy6Rm0rsc=;
 b=M/ZVa4pbD1BFkKgVkbZ7HkOO32zjFBqfczXrxr3xKNnRykjKLweiHDzaW0cvXpydFQ
 PaRrxE06B0dJHwP3/3rwpkwjY2BT3tX376IpPowJsER6qk7DbqQNlTKzzWmd4WYsQT/f
 obfM88bv5UjJzXOSIafxYUW2b4cSeakjsdgen82fafkFjez0tHCo57WxZevpyXt/b20d
 v274fehL4UxQkr1EJmZ9ifQZfIJd4cJCf1d3cs7qzbrpkZds9FNC8PpXjA0uMrxqAaLE
 MgjQeQh37WYcRQMXXQZezjiIzjht13DqkH5uoavWAQBEEb3RMLnhfuTj4O+7IA1Wely4
 sCcg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+2lgXueZFxfXT7VCjQBVN+GYvdgQ/ucFiQXxh7FGQLJZZSeymfJJLdfEyYHG4V+3W1RnE=@dpdk.org
X-Gm-Message-State: AOJu0YxTcrvYQAap2qAreVhbC2tn9HdLCH+sKlUgHG+EorNfS0tLbR3Z
 3IwSjfDcUQR2mvCogeigM0yGAy6zkeYAr1waKnYQBwNKaPE6yPpe2BwPbgez4nwcr6M=
X-Gm-Gg: Acq92OEEUlVeRQBizy4fNdEBlRX4BR9kOTx1JDSZPiKD32gubreXv115DFPWXrI+Rsm
 hxvIDsYwMGLYNwc5NkZmFaM2s8mdLVRLwvHLopUZ7Li8PJrvZAL7vznyaW1qaivQ2fNkReNZz4B
 L0cJ/LuF6yF43ZsDMTfkuo6sSXCIoIf5vc+8ijd5cd5JNchRzwO5hHIi5uaDrtawWur9RjzjMvU
 CfYzIVDJ5fZOx6QJqa6K91UhcDZ2XkCP2aak/Pg1kQz0MaLCVLwVPKyFZSICSfwQNmLUj9kodvD
 wHk4Wt6rHrdNGSwCsi2z325buHDOqLNOMiJMqKJIYhiGctbYc0eTSso9Kw5Grh3wIjOiB5JDPJY
 pG7gpi7wVRI9Hk/Awh1yIx7VaXp6loAw/qE1BON/C6PEBb1IcacmrT7m4MW0fAJXBN8gVLMcylK
 dXeIAlFN398bzMyeuWQh1YcycpM/T/QX7bNaUCjlRA/4RyPvoDz6IAYJMMZkACaFrQQci++kZFe
 +A=
X-Received: by 2002:a05:622a:2283:b0:516:e7ca:589a with SMTP id
 d75a77b69052e-5173a8c4d8amr61924951cf.55.1780159080049; 
 Sat, 30 May 2026 09:38:00 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51741d6b93esm13586821cf.15.2026.05.30.09.37.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 09:37:59 -0700 (PDT)
Date: Sat, 30 May 2026 09:37:56 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
Cc: Ori Kam <orika@nvidia.com>, Thomas Monjalon <thomas@monjalon.net>,
 "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>, <dev@dpdk.org>
Subject: Re: [PATCH v2] ethdev: promote flow metadata APIs to stable
Message-ID: <20260530093756.2aa1ad8b@phoenix.local>
In-Reply-To: <20260529072853.689683-1-dsosnowski@nvidia.com>
References: <20260527103246.633327-1-dsosnowski@nvidia.com>
 <20260529072853.689683-1-dsosnowski@nvidia.com>
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

On Fri, 29 May 2026 09:28:53 +0200
Dariusz Sosnowski <dsosnowski@nvidia.com> wrote:

> Following experimental symbols related to flow metadata
> were added in v19.11:
> 
> - rte_flow_dynf_metadata_register
> - rte_flow_dynf_metadata_offs
> - rte_flow_dynf_metadata_mask
> 
> Type of rte_flow_dynf_metadata_offs was changed from int to int32_t
> in v20.05 release.
> There were no changes to these symbols since then.
> 
> This patch promotes these symbols and removes __rte_experimental
> from the following inline functions:
> 
> - rte_flow_dynf_metadata_avail
> - rte_flow_dynf_metadata_get
> - rte_flow_dynf_metadata_set
> 
> All these symbols and functions will be used by netdev-doca
> backend in Open vSwitch [1].
> Stabilizing these symbols is required by current OVS policy
> to remove the need for ALLOW_EXPERIMENTAL_API [2].
> 
> [1]: https://patchwork.ozlabs.org/project/openvswitch/list/?series=504726&state=%2A&archive=both
> [2]: https://mail.openvswitch.org/pipermail/ovs-dev/2026-May/432066.html
> 
> Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

LGTM
Applied to next-net
