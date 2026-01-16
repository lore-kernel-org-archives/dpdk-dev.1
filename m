Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0908C982DE
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 17:21:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 78A5142E58;
	Fri, 16 Jan 2026 18:21:50 +0100 (CET)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id C4D8D4026A
 for <dev@dpdk.org>; Fri, 16 Jan 2026 18:21:48 +0100 (CET)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4801eb2c0a5so8158155e9.3
 for <dev@dpdk.org>; Fri, 16 Jan 2026 09:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768584108;
 x=1769188908; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SgMSLbllqB3mjEnEhf3i6WQPCQxB4LuztBPX+xsY6HU=;
 b=Pkxz+pgdxkjerQksoVigMrHrdC1+VxYsPmUTbO1sKOM8UhecFuD1bj9Dm4KCFU2MZf
 D5V7h30LhwA/nEkXDaNZr3k1uhHKitybGdpbzCzO72rLP9h44CsEY0tXV1wG75wz/yyz
 cY292OzO/ZpYfhxph7aOugGjjZMGXas0bZnxNzefSsK49HR9Zoe0+Foa+lhPUWMYmNAL
 cY3tcqhlsxVP7G/yPZsz6T+IbdZubmAcMv+RwX02LsoHQPGNAMlUnTtohmo0orZwhWVf
 J1fgOZuUSuxlCpGUSGrDaWf3w721mTyWe44ghw2idRzIg6OeNwGqFiuWlcHMj12AhOET
 JTLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768584108; x=1769188908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SgMSLbllqB3mjEnEhf3i6WQPCQxB4LuztBPX+xsY6HU=;
 b=mF7ihmpZUoS2vO7+kSQ2w9Gh+2Ce8SfFHXDEUMZ+Apz+SQWvaogB8fj6/eWKuYhDHW
 IjMPplaEB4S3KpJ4FhKm31PSzGs3cBqY9Po/QKCKHh+vElCIHlON8jrht2f6lNBSdr0E
 dFnUffL0ISNGpGPOeHMFJ3oLq73jYZxUvh6MVLeMGPGkK64MX20S5vCHWr10hwLNy0wK
 YMNFuKLVqc+AHVSKcILvPw2vXH3vwIk2oI/ZSU5KVGiq4q2gpMAHktWVkIMqaZCFntpF
 aEkuIgdeD0zNfw5g6Fx0wuF5Lhl2xNGiWkXs7nnJ3xZ/fDmg1EaDQyueiKC7pzVjPfRq
 ae9g==
X-Gm-Message-State: AOJu0YxtxDYjxYIV14bzORDY4Hf8fSnJ2TIgIa1tYojtN5jax9Gga4jd
 KIF7KasuQVPI5MDf5MCp3KbbV/ozMhnSPFbjdpFbi+M1cLKsvp2DhYcL5zSFD/EsvVga8+I3e9t
 3O5iL
X-Gm-Gg: AY/fxX5ar8vlj5IpbKlNtU4mtB7iPSHo6cDlXoDC7hZO7Ry7h22yNuZSmdOdD6N14Kc
 K7DxZMFW5OrrzhBZ1RVKy8zZ+bG2gsbM2PLp1VhyQGiKxcKU70BZRrgJMmZ05i7hl+x6/sqaDeY
 P2APgOtnnWINPIocTvP/f5ckX8nXSEe48i9WRBVc9+PT7uP5Cor7GFphGIgVuNYGLrjaFqtlAtQ
 +Pmjy4h0b18xgyx9EE2qfaSyF7gBsbL+0V6sHWOBO7ZrWlS7GlXV3fJITTmsto3IB6cuXHQB76F
 /VznXTXrEqwHJkYXJ25aHl9ZVg/GmpcWvDiEEM0mz+D9mXUwanAVa3w3aGHD/daAhWKMizkUles
 MBL7Y2YK+qvsBvOG7PTYVojFUCmvlqzjTxhnX8eQaY8IVTYs2AtHoxvCFZckN91K04s4mBF5khj
 ditDwEXpzTTTcnvlGYT/ZbyvhIyoNJMKCW0vEAny0fzqMwyn+NCJoG
X-Received: by 2002:a05:600c:8705:b0:47d:5e02:14e5 with SMTP id
 5b1f17b1804b1-4801e2f057emr37342015e9.5.1768584108200; 
 Fri, 16 Jan 2026 09:21:48 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43569921dddsm6626474f8f.6.2026.01.16.09.21.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 09:21:47 -0800 (PST)
Date: Fri, 16 Jan 2026 09:21:43 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Lukas Sismis <sismis@dyna-nic.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v3 3/7] app/testpmd: use shared flow parser library
Message-ID: <20260116092143.543ab6ab@phoenix.local>
In-Reply-To: <682f7f69f26347653492144e9ad23087de3695a3.1768518003.git.sismis@dyna-nic.com>
References: <cover.1768518003.git.sismis@dyna-nic.com>
 <682f7f69f26347653492144e9ad23087de3695a3.1768518003.git.sismis@dyna-nic.com>
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

On Fri, 16 Jan 2026 00:01:09 +0100
Lukas Sismis <sismis@dyna-nic.com> wrote:

> -	if (nvgre_encap_conf.select_vlan)
> -		nvgre_encap_conf.vlan_tci = rte_cpu_to_be_16(res->tci);
> -	rte_memcpy(nvgre_encap_conf.eth_src, res->eth_src.addr_bytes,
> +	if (nvgre_conf->select_vlan)
> +		nvgre_conf->vlan_tci = rte_cpu_to_be_16(res->tci);
> +	rte_memcpy(nvgre_conf->eth_src, res->eth_src.addr_bytes,
>  		   RTE_ETHER_ADDR_LEN);
> -	rte_memcpy(nvgre_encap_conf.eth_dst, res->eth_dst.addr_bytes,
> +	rte_memcpy(nvgre_conf->eth_dst, res->eth_dst.addr_bytes,
>  		   RTE_ETHER_ADDR_LEN);

rte_memcpy() should not be used everywhere. It should only be used in
optimized data paths with variable length values. The compiler inlining
is as fast or faster and static checkers do better job of checking for overrruns.

Also, where possible use rte_ether_addr_copy or structure assignment
