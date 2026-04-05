Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FC2E9D800
	for <dpdk-dev@archiver.kernel.org>; Sun,  5 Apr 2026 16:19:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A005E40265;
	Sun,  5 Apr 2026 18:19:41 +0200 (CEST)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178]) by mails.dpdk.org (Postfix) with ESMTP id 190E840261
 for <dev@dpdk.org>; Sun,  5 Apr 2026 18:19:39 +0200 (CEST)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-2cd339aeab4so1553513eec.0
 for <dev@dpdk.org>; Sun, 05 Apr 2026 09:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775405978;
 x=1776010778; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2gh+uvnnrVzQjwKTgL9MHL2+PtA4AwJhaB79RCZjqw4=;
 b=klpxOo3xAYa9U1PZwbXbGxPuKyBg7bwJ3OXplWC3o7mvD9niTcgmfwp6ilqdI92PA0
 WzMQQaaQG7e6QNPQVRSjwxfOargADmEyJQleijJH0wsR2vB3rlo++rtMIN7lEp6VnCl0
 ubIZ4AYfDY5BdT74ombR0VGgNfr7cDhnMhNDZTa9YhNZBP85y3BY1dhPFPua3omXcYw8
 8nl9ae2rdyheJZPFJTBbcMYFN5BqoEIG3jdySC4rqjMEwWbDrDvuCnmZDkbYfcjEa29V
 v4c6ThDF2rWs2lA6/1Da2KssLa4zzYdiqAoS5d5S6tuH454LGcTyiVGKm20SiTK5fNc7
 EOrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775405978; x=1776010778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2gh+uvnnrVzQjwKTgL9MHL2+PtA4AwJhaB79RCZjqw4=;
 b=WDCRaS8N5ofGIlIbUUG3WzE+5VDEhjhMa4tX8wrU24mCpjvpf0bpOnu8RD1nN3iHqS
 rd64F8e89BPe4YSq4FxaVmL7hGqZTtf2LiCicjz9O3MAf8FKBJI7DUrCmfX/GGn8zfns
 bD0xexf/ch5yFXMhfIc3GbqJcCWVixndBwhQ+8zgUZuKIWnUD7Pp3PtMo+DRuffxt7BP
 BjlXB1pz1+kMmA13C7jSR8GtdN0RLWL9Ons0PAnPogRdho/EDNY/Qrsu5XBAhgf1coE+
 bxUOz5v/g1lCOvdavCk81gDTrY3w1GJgfFkacjxZRyBgR0Xe8HscPXrreWzvNDHOzyDJ
 6eRw==
X-Gm-Message-State: AOJu0YzeJcym66JbOHGBbZ9cWDzuCRQAA24ToQc1O/XK7HQijaKwrgI5
 SPyTOflGFZhD9Lm/qnLYQCRRSOTcjaGBmYNh7Tr5K+m5lK0ByHpm4MEa8OEi1jjtaa0=
X-Gm-Gg: AeBDievFx+3eJnirMNczkw+Sm2GUfrZUGLs1yZ/hjtwdMRjDcpem5YdiBID4CBqRK4p
 qA1yWMOfCBUrNnO4YWXbcpYqFp9sY06vJ2WS3xnbVqHAuXtdZkGJ67YNV4mV32AFzsV5xEJuSPn
 lmYkV9L79CObKfpnZ/9ZIsWJjcHrlIzJI72oUIAFHVlLOW2LZxzjK66B4TMV3tOyypASYdfHjR9
 9iiE/YP4cnzeLbBguJWY5DluYpWerXwlLSbqcICTCTaApIoTo8gP1Mf1da1flJhm0kggvuXKoWh
 qPPeZPSBB+n+ewADvB9UXbG1Z4WROZ+Tdpd+KpqLJSZ/PRhZIUsxdxDSxMTXynqVDbjzjgzyCls
 auDx0t929WhD3bXDgwsyIW+sUjIOjlQTIRwv5cb2PJt7FK+JAjAkjSkEmjMS66lldwkrTD6dfM7
 7BrFb7Yc10vqJeUdgr7glcdX1mp46//UW8aZs=
X-Received: by 2002:a05:693c:2c06:b0:2c8:7172:3b99 with SMTP id
 5a478bee46e88-2cbfa5be574mr4759397eec.9.1775405978007; 
 Sun, 05 Apr 2026 09:19:38 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ca78df5ed3sm10478230eec.6.2026.04.05.09.19.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Apr 2026 09:19:37 -0700 (PDT)
Date: Sun, 5 Apr 2026 09:19:32 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Jasper Tran O'Leary" <jtranoleary@google.com>
Cc: dev@dpdk.org, Joshua Washington <joshwash@google.com>
Subject: Re: [PATCH 0/4] net/gve: clean up minor issues
Message-ID: <20260405091932.5b547271@phoenix.local>
In-Reply-To: <20260327001827.3385001-1-jtranoleary@google.com>
References: <20260327001827.3385001-1-jtranoleary@google.com>
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

On Fri, 27 Mar 2026 00:18:23 +0000
"Jasper Tran O'Leary" <jtranoleary@google.com> wrote:

> This patchset addresses minor issues in the gve driver stemming from both
> compiler warnings and feedback on previous patchsets.
> 
> Jasper Tran O'Leary (4):
>   net/gve: fix comma operator compiler warning
>   net/gve: remove variable length array in rx refill
>   net/gve: add checks for flow rule struct padding
>   net/gve: add minor fixes to flow rule code
> 
>  drivers/net/gve/base/gve_adminq.c |  4 ++--
>  drivers/net/gve/gve_ethdev.c      |  8 ++++++--
>  drivers/net/gve/gve_ethdev.h      |  1 +
>  drivers/net/gve/gve_flow_rule.h   |  2 ++
>  drivers/net/gve/gve_rx_dqo.c      | 27 +++++++++++++++++++++------
>  5 files changed, 32 insertions(+), 10 deletions(-)
> 

Applied to next-net
