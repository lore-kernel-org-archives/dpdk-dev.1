Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B26CD6E55
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 18:24:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA6C940676;
	Wed,  3 Jun 2026 20:24:13 +0200 (CEST)
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176]) by mails.dpdk.org (Postfix) with ESMTP id DE11040674
 for <dev@dpdk.org>; Wed,  3 Jun 2026 20:24:12 +0200 (CEST)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-30759632453so1503023eec.1
 for <dev@dpdk.org>; Wed, 03 Jun 2026 11:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780511052;
 x=1781115852; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jb38kaCXvSIMfdY77qRqBS5b5cjJhNCfxfGDcOdGDIY=;
 b=bB9j8jRNWHfJzfj3CgXRVAsy9FbGKKjCfXJhWJPtHyEj/uaC5UYu7qhjBLfEWkOA6a
 cIGpf0B5mNHTWFl8o4AXjlwdX6mQIrBEXhym707mgmDk+IsR+VKnMMe3pUWsjY6RKahb
 ywnqLhOERf6oKJ462928ZO4/9WaE75oOYam5aYOZh9MBTHMZpNKXCdvPqL8Q1xYHdRzb
 /W+53ZZa0rsotN+IEVOUoFyn4tKSArWgi2MDquqOotT6ehoP6Ma4orcMxaxmsfajlZ8X
 7BBtZj7jyZ/txn5hLVfO0Lm/i0MjVpDEK1Clbq7LCUOSXsRfMv3mO4+yEIR6u7BAgGW7
 dcnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780511052; x=1781115852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jb38kaCXvSIMfdY77qRqBS5b5cjJhNCfxfGDcOdGDIY=;
 b=nDsNDmk6NlymovyLpJ0NL0MqlBD6aYsZsrwb1hBaDVw+BTzjd9/mkMRJvlm76+ewtQ
 YczqrpzgDSPy8T9B5QAHztmwtJXWDdbpU7eaPKDObtXwCSD2SeSbQT73KIywZppSQc8T
 Clhmc4pG0X2vS93UNw+eJo6qJko5a//xZdSSzLsBFCJ6i7JjiAKfiBcGfIhJvlS7f3TL
 77d12ZSs58Hke5+K9b7nCtYdskb/dqivzwEXzSfyzg+ou4XVsX7XxR8iGexlg9paCawn
 izwwYSQpwi8Lbd96ZVJtJzciX+noVkVuB6HxjXXLzfR3Gv8OXlpf6JvyILeaosLl/V7a
 ehFQ==
X-Gm-Message-State: AOJu0Yw7rvTefIVRzcIPwlcWoeGZpyWgNDagxKasf+Ds4pxfSvlHp7Le
 lBTZfNO6C5J5ffLqDQPC10N27qeRuiVR9mmF+ww7CM9vKUy8s3p/QqxPJdfndtUUX/0=
X-Gm-Gg: Acq92OHFRP8Sgz4TUFsaGsH+tp0vP370PTMH8mZzyLEMJto/WZ7WEa1aQYDvQc0Lcxf
 IVMjDO3a5TZUmUXudWerIFV74p/VQlV0UORb1XyIN/GuG64V2sm3Bw0wFnAjll5tx3sOINgofno
 tWbHAAR86q8e7aZEEBypridwHdXbkiYZhAxvimJtK/+hki2ehpL4sJzXPc23JGHcpH0oMiysMK3
 bmCvjK15fG77vfwRNuLGSBg/qXqxX5uZPNVDL44P3u1vF6oGZjEA4010cLYrIHHWUpPnT6qSZ/d
 RzGx9GekUBfDYx7QixsSzAK+NIUcUl/FIOfIYG056dLFfOESkLN0HHAtLPLf+i5+NTPfnbbVPWa
 wbDNvaRZkb91P+9/gGI/bswtY91HhlAcIwVaEASPmkiuiLfwSJTzRkPPO7Jd/V3R7Gg0LzpOQyb
 8TzZnH/5iMOvNbehFnL7R80+70QJEaPa7uVDxs0Ucgen6B90CgpbRQ/GGJqX2vM7jI46syJ5el3
 LA=
X-Received: by 2002:a05:7300:ac90:b0:2d8:97d6:6abc with SMTP id
 5a478bee46e88-3074fb78774mr2629702eec.22.1780511051918; 
 Wed, 03 Jun 2026 11:24:11 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074df805d1sm2682632eec.28.2026.06.03.11.24.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 11:24:11 -0700 (PDT)
Date: Wed, 3 Jun 2026 11:21:05 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v8 04/20] net/sxe2: support L2 filtering and MAC config
Message-ID: <20260603112105.02546fe0@phoenix.local>
In-Reply-To: <20260603062945.1253672-5-liujie5@linkdatatechnology.com>
References: <20260603022150.1140722-21-liujie5@linkdatatechnology.com>
 <20260603062945.1253672-1-liujie5@linkdatatechnology.com>
 <20260603062945.1253672-5-liujie5@linkdatatechnology.com>
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

On Wed,  3 Jun 2026 14:29:29 +0800
liujie5@linkdatatechnology.com wrote:

> From: Jie Liu <liujie5@linkdatatechnology.com>
> 
> - Support primary/secondary MAC address setup.
> - Enable L2 broadcast/multicast filter bits.
> - Add multicast address update logic.
> 
> Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
> ---

As part of "inclusive naming" DPDK does not allow use of variables name master or slave.
### [PATCH] net/sxe2: support L2 filtering and MAC config

WARNING:TYPO_SPELLING: 'master' may be misspelled - perhaps 'primary'?
#264: FILE: drivers/net/sxe2/sxe2_drv_cmd.h:238:
+	uint8_t master;
 	        ^^^^^^

