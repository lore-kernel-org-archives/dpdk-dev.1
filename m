Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517C8E9A02C
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 00:12:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 46882402C6;
	Thu, 19 Feb 2026 01:12:09 +0100 (CET)
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com
 [209.85.167.171])
 by mails.dpdk.org (Postfix) with ESMTP id D4046402BD
 for <dev@dpdk.org>; Thu, 19 Feb 2026 01:12:07 +0100 (CET)
Received: by mail-oi1-f171.google.com with SMTP id
 5614622812f47-45f09874c4cso218034b6e.3
 for <dev@dpdk.org>; Wed, 18 Feb 2026 16:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771459927;
 x=1772064727; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q+wFRc2hmDjU8QEhv2jbMjfpeRQ4sgOm2pxMjzZ4dFo=;
 b=JjxUjaSEpd+tAs/w8N2N2G+cuy09l/Y8M7zOct5dZstW1bqUFUfwh7NAM6O2qzZEs2
 68IvqnWjkNxl/osstkft2FFzu60aeUgMI96GQOALvS1wh8dZ5jipHdVaYXNzItf7B+P/
 nF9nNj3CLlkSRFDQOHuNK6f4DBHVVifKcwhlStEWfw5ZxQl1L8drL5woyI2wYrx/l+Xl
 Morj68sbX96TQa/mwjAALVCRVHozZ4ZhFqoLA77RpDrPVuR+A2PoifmZbsmrR3oE2s25
 R2wn3U+lJDHZuxoJSJYE2W/Pe84IrD66GsVeVPrlmCkHTwvYOwbU5ORwYKbcVQK9D6yP
 AXpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771459927; x=1772064727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q+wFRc2hmDjU8QEhv2jbMjfpeRQ4sgOm2pxMjzZ4dFo=;
 b=NLM6W9e1z2dlfeDROlAc5lgFCpKT8CDYcJSaFd7P+AjWwO01WfrWjm9V11JOTc7u0r
 RzdKJT4+P5y9x7zsIZIoeWHBeZzyIFcn83jh+5W1Lx79KxLNliIU8HSGDYFDHEP6TRpp
 F6kOOSaZqxjpSm7rGWI1Jfxp1r/2NGHxHfFm7e3MQVVqCXdzStHWyvJpvuWLXmjhKMxD
 GlhyVHGhCgozaJIaSQTBvoL4AFPcAi+4PYEem3WFR/TFjCvJ4W47dqt6QRcfovDYm5Mn
 UBVGH77dgoNjWC0VKulncCO8QdKVYJ/9oTHcGn9MPmYddrzuqfYs1gjt/9+uw2ndsiQ7
 nkyQ==
X-Gm-Message-State: AOJu0YyKjg61Nr1AvFTE2dn0rngbQbLzjkvm/fTmArUku5DjZjdPYttt
 rbsDIdV4WDkVyVFYi56oE0gubqtslztl2mYHZyDRJQPA+ah/uTIHCn5gOxuuNBZ5JGgtgQDmR2t
 EQvyk
X-Gm-Gg: AZuq6aI4R7fR60uIuHPKptWKKItIycMrsLg3GGdswBDDa7IPj3u88CdsGJOppQm19Gx
 CqdYLXfsD4JYHl4PHPfWABnB6QRDN2cOH3e0XjPbM7OyRb5FYcL4lW1nKhe5QSCPg90x/xtKBhQ
 oU6ErmUlu+ZR+M19yKoFBN0tjAt66Sof3kxn/R7aQwM2jSUNleK6fLgPIEHuMtvJcl7Gf4TX4OL
 /RekvmD6V2YAWarsPd1Yyf+urCowldx4J8C3xDZDfFKndduycXarg09+/MsFcyMuQGdu6OBebvp
 BX3aHIQCPXcNvVuReb/i38DABA3DCXh/kkqJMcj1XT9Zv5d3Klc6uNqzjfRnVyQwxZOyygoUEmJ
 x0OYXd16/oR0NZvq21fl6Ip2UMY47SfaqJjqLJaKMt01kb7jcdGzVM0VPSIT65fJRJNPLUOeeQ3
 Ne+TY5Jz/zhc0HVvaBWp0FUJ2a0cgCNpy4imU2mXafDLyEDh6u4oeJ57EwB8fgsILU
X-Received: by 2002:a05:6808:d4f:b0:450:cf73:7703 with SMTP id
 5614622812f47-4639ab5f4d7mr10549763b6e.12.1771459926624; 
 Wed, 18 Feb 2026 16:12:06 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-463ee1f67f7sm5736350b6e.12.2026.02.18.16.12.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 16:12:06 -0800 (PST)
Date: Wed, 18 Feb 2026 16:12:02 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: spinler@cesnet.cz
Cc: dev@dpdk.org
Subject: Re: [PATCH v10 0/8] net/nfb: rework to real multiport
Message-ID: <20260218161202.314d78eb@phoenix.local>
In-Reply-To: <20260217071040.2855133-1-spinler@cesnet.cz>
References: <20260115151656.393106-1-spinler@cesnet.cz>
 <20260217071040.2855133-1-spinler@cesnet.cz>
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

On Tue, 17 Feb 2026 08:10:32 +0100
spinler@cesnet.cz wrote:

> From: Martin Spinler <spinler@cesnet.cz>
> 
> This series implements real multiport for better user experience.
> 
> The existing driver creates one ethdev/port for one PCI device.
> As the CESNET-NDK based cards aren't capable to represent each
> Ethernet port by own PCI device, new driver implementation
> processes real port configuration from firmware/card and switches
> from rte_eth_dev_pci_generic_probe to multiple rte_eth_dev_create calls.
> 
> ---

Queued to next-net.
