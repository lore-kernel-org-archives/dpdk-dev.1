Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B12C02198
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Feb 2025 16:51:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C4FCF40156;
	Sun, 16 Feb 2025 17:51:33 +0100 (CET)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mails.dpdk.org (Postfix) with ESMTP id 9543F40150
 for <dev@dpdk.org>; Sun, 16 Feb 2025 17:51:32 +0100 (CET)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-220c8cf98bbso73285955ad.1
 for <dev@dpdk.org>; Sun, 16 Feb 2025 08:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739724692;
 x=1740329492; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RVpGacQ0uxDNemsY0SmbonZ3S9xrZln+NAk8ETDmtOM=;
 b=qmHUEL4eg31ouPpkYV8RpJ0I5iU7mwvHxSXBp55PmIzaZYsQ+LWp5zBOnLcNtIlupB
 FY4AfAEJd3ZcFSo0zWeyo6Syt86W0PvmC6xG2XMQwqeLXN2FjPqJrpBAMHqMZk6sYkF+
 ccpiK+3qYEvYU5KqW7wpw0iYXseVQgfOWIuqe5Ww2/tJvnufLHBNNChJN42Ms18kYjvA
 hoQn43KfixVyXMxt9ih/aKCB7XV7RBwGYv8k+uznS8S6/oq/s/ZE8jBFIVKluMlKNAmO
 pDUcpR3Le2TbQeMXqBW0HLWRUL6mI82V9xJdwHDWVFp3wwlo7xdZzwXw17QFArbWUwhQ
 TrCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739724692; x=1740329492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RVpGacQ0uxDNemsY0SmbonZ3S9xrZln+NAk8ETDmtOM=;
 b=MOb3X2vB3QVO32Z6M6UFWFjbKdukpiibw8ugcf6nuFx81uTrufYdxclhc/DxRdzMdW
 7L01kyJ9n3BRaQy0rXe1sc7LQr3pRfxJo5KbAOotm2U5ngmDSLPQ8YG6q5UdjrjX+LCE
 s0XfGla74DKsHDI/JQpHUWLLLVFu5t1GMQAvecPwXZtnEvPUz2cCmSzylOISVdM/63Cy
 QkXpM2GW28VwE6Xs5iNcn0/BCtFPj3AZjlmEkc2tFjK0fu7e5SRRz3nUZU7bmG4c7FTp
 2pE8fZes4DJSkYLEfbbHA/Mw3vZ2ITMQ1rknBoe7MMXcS9Gc/d+WQMQriDct1Fh5rMed
 muEQ==
X-Gm-Message-State: AOJu0YyqxYc3GfX0vqfA0S4wAT2IIJLjnTb7nixdjZO+vjdSYzPX4OtZ
 CYH70YFYANCtQoXe5qjrz80Kl8jGL7sqEINGub23sd0jIEZvRB9cYE0/XtbGi9w=
X-Gm-Gg: ASbGncuLNc7AOHVpyjvG9q+FQoe+i/APUIfpxTxnggOuGU6nudVg4Du9cyqpctGA/H/
 zBCfcVaUZC9Qs9HkwgSjhCLuwZnOJUqimcu4+lI9TWNxYw1dAdC3IybV3GwpSw0qyKO7EjovB0e
 7AiGN3JYI6OvmsApdQnjnHNLFz6/ngwwTTCuhdS+v5SoSOJdQ1SVUe/VxkZnyt3hBP1nrX6ICNd
 5z5OH+zVD0TjXbAeZvkMJOnCiLxoZyA2S7QijWTN4C+fphvj15fl5a4gCX2dL7WiEu8huz5zRBA
 o2E4c1I969GN+SmgrmBIp4/GOkGo9SeDHiyix6j79kdzmWL2rv3X7p4hYsQXUdVJvwGJ
X-Google-Smtp-Source: AGHT+IGAqCmxqwtPYcCEBPhaj40ylpXKSt09ck9qrUFWxkyC+NU2mubKUuVBZaNmYM38t30dTyt59A==
X-Received: by 2002:a17:902:e80b:b0:21f:1549:a55a with SMTP id
 d9443c01a7336-22103ef57e8mr109563755ad.1.1739724691647; 
 Sun, 16 Feb 2025 08:51:31 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fbf999b5cesm8120080a91.34.2025.02.16.08.51.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 08:51:31 -0800 (PST)
Date: Sun, 16 Feb 2025 08:51:29 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ariel Otilibili <ariel.otilibili@6wind.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, David Marchand
 <david.marchand@redhat.com>, Reshma Pattan <reshma.pattan@intel.com>,
 stable@dpdk.org
Subject: Re: [PATCH 1/1] pcapng: fix null dereference in rte_pcapng_close
Message-ID: <20250216085129.4b2666f3@hermes.local>
In-Reply-To: <20250216160833.3216001-2-ariel.otilibili@6wind.com>
References: <20250216160833.3216001-1-ariel.otilibili@6wind.com>
 <20250216160833.3216001-2-ariel.otilibili@6wind.com>
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

On Sun, 16 Feb 2025 17:08:33 +0100
Ariel Otilibili <ariel.otilibili@6wind.com> wrote:

> rte_pcapng_close() might dereference a null pointer; as example,
> PVS-Studio gives its usage in test_pcapng.c: indeed, that call to
> rte_pcapng_close() might receive a null pointer.
> 
> Link: https://pvs-studio.com/en/docs/warnings/v522/
> Link: https://github.com/DPDK/dpdk/blob/e5176f23ae8b31437c3e5eb875c81f95bf3a9942/app/test/test_pcapng.c#L438
> Fixes: 8d23ce8f5ee9 ("pcapng: add new library for writing pcapng files")
> Signed-off-by: Ariel Otilibili <ariel.otilibili@6wind.com>

Not sure this is necessary.
The analgous function is fclose() and calling fclose() with NULL will crash.

I would rather update the documentation than silently ignore buggy programs.
