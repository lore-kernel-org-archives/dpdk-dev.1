Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB03FCB61E
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Mar 2026 16:34:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA7C8402E3;
	Fri,  6 Mar 2026 17:34:35 +0100 (CET)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com
 [209.85.219.46]) by mails.dpdk.org (Postfix) with ESMTP id 865C940262
 for <dev@dpdk.org>; Fri,  6 Mar 2026 17:34:35 +0100 (CET)
Received: by mail-qv1-f46.google.com with SMTP id
 6a1803df08f44-89a018cbbf8so68049596d6.0
 for <dev@dpdk.org>; Fri, 06 Mar 2026 08:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772814875;
 x=1773419675; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ym9knaqXVQ/Oa+GiZSvB8vAV3UMcgzhoO5t4RqQJXzw=;
 b=h6DfepmT462ADBf4SLD4SxUiMYCoyYen9td+0UtXtN5qavCBanmQJ1Ay340TiPE01w
 ouhHzyJKm+l+qj7SWOFizpJqdJgo/NSylMbBrPkh1gE/9ielPgnabwJRjA47c/nA+eSn
 6H4dwqPTiYUaCb/wDkuYKXk337gVAG53GJfstiLCsKwnp7ISXX4o/Fk0WOLTSRf4dnRP
 pvucTHdsxYdenusql4TcKQyXYHYKs2a88dOac+Un0TtxGakYX3G7m6OmHPvtHInBM552
 Wal/pawiW/yGyj67tg/Fm35Nofh2S+YrqpVeQC5iErGw9k/x/fT0oXapR9/+tbfdakKb
 YEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772814875; x=1773419675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ym9knaqXVQ/Oa+GiZSvB8vAV3UMcgzhoO5t4RqQJXzw=;
 b=YtV9zuaRGIgkG37Tl6M+C0kVTPE+EMUjd8iD2HqOs28RsiYyHE6m/LNuzpqfJtlSah
 2xobtkw0DaNcwWxhPIP+U6sW4xmGuj9F5aaWeBb108fllsthdypS2IDp8xC6g+bTLyku
 WOAoS1hdi73D+Wk6EPanbgLUFx6rEfrETFjhuqj5wpk+Df195wV/bvoazhGTT+D6Ik4G
 V3P74q41UUWvW5tLCMA4h981eaRki0SFukt57+c/T9mQ67aksgmhDdcU0bY5dLFkFTuX
 7tvf6Jg5D4wxUy6VnYDq7jKQj7xr3qgmnQdeweGnjUm3KVO1PGE57TkgN3a2UyNRq3fF
 1YIw==
X-Gm-Message-State: AOJu0Yxblo93U/cw/UHPd1HFsTF8zWoJEvYUPCu7litO2ngkJeFXogm8
 Vi5wmyW5Ji80OSXfTYag3m1rr8Fql5H6ug7EtmYXmhvfkgpj3GtA7mC6w1cLm0p5ZzY=
X-Gm-Gg: ATEYQzwHdcB8elbobdhsRO3DQZyiD5SN027sJUbgXL5qAOJaFAONxvOQWhBWyR4wrTs
 fcG5vxBXkEqXRFRiXqepHKa78/QGU3fJyu2/5xRtRfWirJuPkykOech8ezBCcRuQZ939EAXRwSO
 n6pWfqclkhAvvW+Hp5WQXYYMVVyYK5CAop+jVUUI4JLYwjZKPruLLacNI+UmXDDM+ajpAlW4+jt
 FP9HZVNk5X4a5NYYOH8DzlEYYMM4CLu5Sbp6wQ+QXBh52LydeLk60lWrjtd3AeWoVcieJ6eeDlm
 sGTFSsvnMk2TGmxyKwvDoXv2R+9l7hFf5ya+NhCONl1Ftuj7/WNRJtojrqQGOvuMyWKVZZZqsxE
 lW+XE5MGOltsdExhSGa1SwOaeKZysHvR6mpDgNpaDu2nkc48j3OgOvQ7GYkTgocdhjFNY2RYBFM
 5vjUZRq3zB7HuWfbceVjNTOtgzfgJ2jE8dXO805/EvNYS2zdCaGUpubQt8wBeDy0Tb
X-Received: by 2002:ad4:5f07:0:b0:899:ea7d:8df9 with SMTP id
 6a1803df08f44-89a247f7a30mr99072066d6.29.1772814873783; 
 Fri, 06 Mar 2026 08:34:33 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a316da913sm19405526d6.29.2026.03.06.08.34.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 08:34:33 -0800 (PST)
Date: Fri, 6 Mar 2026 08:34:30 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Mounika Kalamandala <mounikax.kalamandala@intel.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, aman.deep.singh@intel.com,
 shaiq.wani@intel.com
Subject: Re: [PATCH] eal: clean runtime directory files on exit
Message-ID: <20260306083430.7a0b73a6@phoenix.local>
In-Reply-To: <20260306060822.328329-1-mounikax.kalamandala@intel.com>
References: <20260306060822.328329-1-mounikax.kalamandala@intel.com>
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

On Fri,  6 Mar 2026 06:08:22 +0000
Mounika Kalamandala <mounikax.kalamandala@intel.com> wrote:

> +    When the primary process exits, all secondary processes must be terminated,
> +    and then restarted after the primary process is re-run to ensure
> +    proper re-initialization of shared resources.
> +    If secondary processes continue running after the primary process
> +    exits, they may experience reduced functionality. In particular,
> +    inter-process communication, new memory allocations, and other
> +    shared infrastructure will no longer be available, which may lead
> +    to unexpected errors.
> +

This wording is a little too soft. There are absolutely no guarantees about
functionality when primary exits. Driver may crash, hardware may be rest.
I would choose stronger language.

