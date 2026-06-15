Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3AADCD98E0
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Jun 2026 21:32:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CD85D402F1;
	Mon, 15 Jun 2026 23:32:30 +0200 (CEST)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171]) by mails.dpdk.org (Postfix) with ESMTP id 7FAEB4021F
 for <dev@dpdk.org>; Mon, 15 Jun 2026 23:32:29 +0200 (CEST)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-3078e0dcd67so4119241eec.0
 for <dev@dpdk.org>; Mon, 15 Jun 2026 14:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781559148;
 x=1782163948; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7v+Nermoy/0R4uU4626I76KsM7fsBSh2SSyI2ieiGyg=;
 b=OG+rAl0WFoXMBT3UkyNHL9wUWwcQ81kISxvchPOrECVf2dj/gxrVJ5y9lRMLa9wow+
 nzrIC+OwBCEdXWexjxzO6zJl9mfqKQN6SbfDvnPA6CSTDmV7jpAlW08YsXL8UUMtD9JA
 yZIKCn2ge1epnXKJ390rO357s+SaGY4kv2iY8CdeQIXsBzXOZ/rqqALNlw/jclE9B4KZ
 eYHj4BejteBczR5BjonNDiWMzEuusddokOHzKKEuc82Mo+8wrOvsMIc/FG06eKSsiUOF
 OzQEbx9FNB9H53RcVeMbmukJT9x2WDtBcXtzq1KDbHpCTDIXIF7jNBOZepHLt+oV+eu1
 rEIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781559148; x=1782163948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7v+Nermoy/0R4uU4626I76KsM7fsBSh2SSyI2ieiGyg=;
 b=gA05eUhw3lSg+2rYFMdWjr9hCLjyrmA4CsWdJoPU86wRjr0itA7w1KSk0fCYQz8/W0
 zHWEBWgeTyb8lAAtvWbcCZqEhxy5JMPjbD3ahkTxbRXNNA543yB2zu0i0q3cZjO6TeUU
 O5DrDINteaEaXSbEbrmP5/MtUHtugMd6CI3CbbozHofVv6XC6PdPhRP9G8dAeLWaCpnT
 9340gpx2zdY4v1B6EolrIc7HgDpfunHiBJLb9ClrOIEek2VnM/5H6nhOWlhpbo4RzqbB
 MDpZD7jnMcu/WhW57lPrFPiub6ZyXxICO3B5s33UfL4oxTw7tCzpQhQh8F7fUHhoY7WM
 9aOQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ttOL3UNIq4Cv3gRsRTMR8Cx0jdziedLCSPU5l4unNrK5T7meyCOqh9YSp7zZ89zHSCUA=@dpdk.org
X-Gm-Message-State: AOJu0YwXzZw9Z9N8wCIskMGfvF8QFvrxDuYHXpBC5w9MGGOxTCRccPUe
 tKiwD4hl/nodQAMQB+jg7JxQuwEXPvQ1f+BaOAaKUlMFSEx9730CWsEFWWup+rrMsI0=
X-Gm-Gg: Acq92OEPjQnQUzKGVGU4l9oy1AgWnTlDMla58a6Id7dw8Y8Sf3btGhPzMqJ8cdlNtyc
 CvU3amaoBSQKSqThYBcE65wVxogpbyA9b9mKdbIzj8aob9VPfiM7yAYZyeLzqBs3ObXszc48iHk
 bvV4xIKZKH53nyJvrtUN8cYJdlEEGYQKhetayms9wbcSmsTRQ7venufcdPTempkx0vJkprnbYHi
 fZ6oklz3EjoHzUKEd2QGUxbrjvawB81prZQI9OJVwvRd+ufaiNkRcSV4G93kTI5sZxf8qdFtjH1
 pxaZi7Z/dkM/nlLITQyeK3aV96iKZf9QMN+XFx3GdukCZ+8WuBeR570xjbE0v7nmuhGEvpiFTUn
 hwhcmy+QT7qwGvtqqEjQCrdYNhWkeMlgcqL4iIsh1FA9bjDyjPj7JXsTFPtClO/1T0vUEGmkmWn
 oHiG7VkDDmqne6e6Ka6YG9gmFTWwpL4xCnhPB7sA7w8Fg+QToZI89lAQRcWMTxyo2Cvvjop3Oj3
 Aw=
X-Received: by 2002:a05:7300:724b:b0:2d9:2b54:ea9c with SMTP id
 5a478bee46e88-3093b94438dmr7085300eec.18.1781559148306; 
 Mon, 15 Jun 2026 14:32:28 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081e4898c0sm16766981eec.3.2026.06.15.14.32.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 14:32:28 -0700 (PDT)
Date: Mon, 15 Jun 2026 14:31:29 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Shreesh Adiga <16567adigashreesh@gmail.com>
Cc: Bruce Richardson <bruce.richardson@intel.com>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, Jasvinder Singh
 <jasvinder.singh@intel.com>, dev@dpdk.org
Subject: Re: [PATCH] net/crc: cleanup code in net_crc_sse.c implementation
Message-ID: <20260615143129.6f344b06@phoenix.local>
In-Reply-To: <20260612025135.298226-1-16567adigashreesh@gmail.com>
References: <20260612025135.298226-1-16567adigashreesh@gmail.com>
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

On Fri, 12 Jun 2026 08:21:35 +0530
Shreesh Adiga <16567adigashreesh@gmail.com> wrote:

> Special handling for len between 16 and 31 is not required as the
> implementation correctly handles them in the main path. Given that these
> cases were annotated with unlikely branch hint, it should be simpler to
> have these handled in the main path itself.
> 
> We can remove the partial_bytes label as there is no jump target to it,
> and replace folding code in that block with already existing inline
> function to simplify and have better code reuse.
> 
> Signed-off-by: Shreesh Adiga <16567adigashreesh@gmail.com>
> ---

Looks good, applied to net-next
