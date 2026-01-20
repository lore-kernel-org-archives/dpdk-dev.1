Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50279D2ECF8
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 00:14:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A3C2D40673;
	Tue, 20 Jan 2026 01:14:34 +0100 (CET)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53]) by mails.dpdk.org (Postfix) with ESMTP id 4A7E340674
 for <dev@dpdk.org>; Tue, 20 Jan 2026 01:14:33 +0100 (CET)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-64b9b0b4d5dso9932454a12.1
 for <dev@dpdk.org>; Mon, 19 Jan 2026 16:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768868073;
 x=1769472873; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0HJX6C4EVTgJm8eUUcjMA7ffgvSk5q0BIf3Kg8n1KtA=;
 b=nl6SSt1awoNkLUSAbZyoGGkMUeWg3nnnj8IrQbmguTAx0PSJz0jDBDC+/fK1/NBIb6
 KjTz7SPiuDmQAv46T7x9DrVZ0Z4pbCPHisJYk0AH+rbcy4DYFf+zvASdDrjEBphKaBib
 Qhavt8Di1lkGtgGXY7nCum/Or7QYf99akHrXjahyFDJJ6Zohep8i4JcuGd+Mj1nbP6Aq
 /Yxol0y7eLv6HCrIzPNHC2iWlmI9QxVDOurzBu+GZaXhdBMhdQKkhZJWaUADcS+8bsPK
 uFQgpgx4cSvYBQQzdKWn2j5JWWW0CLzEixlrMqhuRdSRXc/JHcNPVWW2b5bJf/OuyzpX
 uInw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768868073; x=1769472873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0HJX6C4EVTgJm8eUUcjMA7ffgvSk5q0BIf3Kg8n1KtA=;
 b=Tdk5RNJX8ZFO/+OsiIYZovv0pPB/ip4AI8Uv48Cu4H1hPgSia8bsCdfQu03iqEgWDF
 WlJ/PcjZPT+ojKcJsyYWoVAgSCFHZ7QGSin00VIGiT2x0sBUNFFv7IvM2/6MNWMUV4Wj
 JvoslNH/BgeIpe0q/nj1mxIQOau300XRwrL1tABMfFlk3Vm+8gXSAW0Y6R++iq0yAC96
 00C8VjvcQoFwCdVT3lDpnWzvdU8qE36ABX10bYT9cgJK1SaMBNeowybBTnvHjgTbHYLP
 53nReqnfKrNeh4heDQSH6ol6OYZu16+Lh9IfC9PNP9gohFXzR9vRzCtLAsR3gB8wgPqx
 fnjQ==
X-Gm-Message-State: AOJu0Ywnt3CEix+yPre1UEKAV7jaGV9vxH0K2xrGvfDcpFtB2L6AoCAE
 OqlhTG6L5HF3ltsdZLd6NvdDkwNjRSDzDIoA3haaze4NXKSbPpKstfS4BRyYyNlJHaWwaooSMyc
 GOaTk
X-Gm-Gg: AZuq6aJe0kIcMwNzIxUIblRtoZB/NYx9Bt36FRkvL/Hzz+fzbU31ABHuSVTzb4IDdKV
 9ctA4D/Xxmz4OGDhd9++xYQKTm492xzHJxjHk9NuQ5IQ0zmaqKBklzyV4ASD1ost9X5lnVZyJoX
 rkIPTVaaAwjuZLu6N5OjVLg1kKEl8+dcWtawtdBkZwj8A2BsBUyKeRS3FNhudNGow2UuJSoxbK6
 cw1cacSnad5m23M/bi6V1agyOj94csFKDMPbBKEUoSHWregUWnzASCQF7zpAm+keCD9fGB4Ozrf
 iICJRUihpA5B4RKC95LuyE6k/pEMed0u2+ptPVWqvSEae4hcqR/0yQkg4elMx7Bx+rYSabrunjb
 2JtiliG10Ao2+p6pLp66y39hTOGUDNmN1mUaDoYYFVRUT9hjwWZOOD41jF67KJ60ZKHPD7SAYTP
 KoHAjO6AJcLdSeRYpKg7rgon6DAifMJunxBlIlJr/+qZtKNjQeFzEu
X-Received: by 2002:a05:6402:35c7:b0:64d:1a0f:6968 with SMTP id
 4fb4d7f45d1cf-654b9365373mr9869571a12.5.1768868072915; 
 Mon, 19 Jan 2026 16:14:32 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65452cdb0e4sm11388853a12.13.2026.01.19.16.14.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 16:14:32 -0800 (PST)
Date: Mon, 19 Jan 2026 16:09:36 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: spinler@cesnet.cz
Cc: dev@dpdk.org
Subject: Re: [PATCH v3 6/6] net/nfb: stop only started queues in fail path
Message-ID: <20260119160936.466f9cba@phoenix.local>
In-Reply-To: <20260116152057.1456380-7-spinler@cesnet.cz>
References: <20260115140134.235877-1-spinler@cesnet.cz>
 <20260116152057.1456380-1-spinler@cesnet.cz>
 <20260116152057.1456380-7-spinler@cesnet.cz>
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

On Fri, 16 Jan 2026 16:20:57 +0100
spinler@cesnet.cz wrote:

> From: Martin Spinler <spinler@cesnet.cz>
> 
> The driver should stop only running queues in case of error
> inside eth_dev_start.
> 
> Signed-off-by: Martin Spinler <spinler@cesnet.cz>
> ---

This is a bug fix, shouldn't have a Fixes and CC of stable?
