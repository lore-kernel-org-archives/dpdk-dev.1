Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAC1CD98F2
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 17:33:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BD490402B0;
	Tue, 23 Jun 2026 19:33:14 +0200 (CEST)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169]) by mails.dpdk.org (Postfix) with ESMTP id 3194C402A2
 for <dev@dpdk.org>; Tue, 23 Jun 2026 19:33:13 +0200 (CEST)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-30c6040aa54so88422eec.1
 for <dev@dpdk.org>; Tue, 23 Jun 2026 10:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782235992;
 x=1782840792; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cGNS0gphJ/RU1r2mzDauh+Y5AwbslOH7p60+DNBKBk4=;
 b=aG+ap0V8LDVDF5Lqzmq02t4zgBfW/19e3BOmMrzEFMxwIUFSre5P/xRXlGflzayvqk
 lW/H6Uql71rXtpDEOjnaWNv8r1wLtku7s9cOijcmoIYmSaQibpDwp6yBsonvbbwfEObb
 eeTqw5/RSbnaAGNOcOb8sV8IBNTYHQjd0Az6A6Ri8ZutkqBAWleVt/UrEBABCpnVOmwR
 EkB3uzuL1qNCXogRMpLY1OI5kiAurXXP+3aDK89B42c5Y8pbAdhJHXqEdaIFiIjtNTd/
 wG0fHSU+awril7EOue+yDxIrVcKlEBL+aUNH4QeFTsZbZOz0DLwUIANxc9GV8RrnhcZ1
 NJCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782235992; x=1782840792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cGNS0gphJ/RU1r2mzDauh+Y5AwbslOH7p60+DNBKBk4=;
 b=AXTI/KmLDM49bmnW5WdyZWln93ea9uxo/F9rBQnU7MfKgsPhiYFOYGOLmQNjr2w3fU
 VCISwlJbcUl7turZkdXJstrZzjcPMcVPG7koVY8MhzV1ktlMkPvNRG9NsXBVKT/CBfUZ
 FbUCz5yOcXCjYSSrccACaD0JLB/AErv3SeWS7q/MhJrfRd01JQt1DdeQ9FQOHJMu2HZ8
 NC0eGvMJZm+KAYtNi9bpesMdZtnpyirM4ID3hRUVk8hKHsV5kMLREOG08201PUrcA3ti
 ikQbuM1oX3luYcfhf+HAHjNEo0IVa/kTIBtltOl8zcxyT0+Xlbq3rOC0VNtwQE2LIt8Z
 8SwA==
X-Gm-Message-State: AOJu0YzvBM8Q8IAf0gwUNRH3M4RTy/gH4e+8MYK6UHb9d67HNGyfop9/
 KvvLfSc17eciJ99Htz+v7N2lKuxBHAIAAhqxIwabn818EoMdVOeXAhr7JEnZEr+Nveo=
X-Gm-Gg: AfdE7cnOZwy+tUWydcgKXmWxHRodEzEaI3GIeQKI/5EffWAbfZR1yqqu9gN/7Xun+Ln
 T3LU1FPsr07qSdBy/Uc0rw+MUBzu18szfEWrtgguhmnBvoj/OrOqqQrKCFOHbssFV0/t7PMzfD3
 lD2zlbCAG/+/FYIES2SkJFhLz9gNQ+RZKXaaGdlrmdGz21WgTv8wzGtM0lKtzHXbmUuVKsRtEnO
 n7COJMnzr8Q1L9GntIAhVgHxSq7Zok0IN0NdLUybo5skZ4OgAF+XUhm2x/jSjNhTcRolDGVzJEP
 Xywg0w0PhxKcSuV/UKh9fkoUgjeRdjSRpmt4t8om0xGkxzs5traUqkmJHYm2ZPjYeK8DV5xZQ4M
 eznlVTcD30gqrYhvUg2RLSVeQqz4aGIfzNlkb0+AxzwZs89mVyvNkGg7RSdZOvf7Ii8xCC2P+CP
 7XpJcb9NjTm5VlAwucc87NfWNQTL4XtEZv0ddWdr/xLmz2HgpSN1oq1A==
X-Received: by 2002:a05:7301:5f0f:b0:2ea:5057:a304 with SMTP id
 5a478bee46e88-30c691294ebmr3704eec.2.1782235992108; 
 Tue, 23 Jun 2026 10:33:12 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1bddfe34sm20590415eec.20.2026.06.23.10.33.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 10:33:11 -0700 (PDT)
Date: Tue, 23 Jun 2026 10:33:09 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH 00/17] drivers: replace strncpy with strlcpy
Message-ID: <20260623103309.50529876@phoenix.local>
In-Reply-To: <20260623165150.765443-1-bruce.richardson@intel.com>
References: <20260623165150.765443-1-bruce.richardson@intel.com>
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

On Tue, 23 Jun 2026 17:51:30 +0100
Bruce Richardson <bruce.richardson@intel.com> wrote:

> Many uses of strncpy in DPDK drivers can be directly replaced by
> a call to strlcpy instead, which is safer in that it always null-
> terminates the string. This AI assisted patchset makes those
> simple replacements, adjusting lengths as appropriate.
> 
> After this set, there are still a number of drivers with strncpy calls
> in them, but those are not simple strncpy->strlcpy replacements, so
> left for later rework.

Maybe a coccinelle script?
