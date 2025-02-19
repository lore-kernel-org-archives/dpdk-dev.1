Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C399C021AA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Feb 2025 18:46:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 439EF402A0;
	Wed, 19 Feb 2025 19:46:00 +0100 (CET)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by mails.dpdk.org (Postfix) with ESMTP id A5CCB40263
 for <dev@dpdk.org>; Wed, 19 Feb 2025 19:45:58 +0100 (CET)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-22128b7d587so621135ad.3
 for <dev@dpdk.org>; Wed, 19 Feb 2025 10:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739990758;
 x=1740595558; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JqWEJ+iusIh3WGYUAKhkQ3qSD1adLwMYAmrB8kn95AQ=;
 b=QtejmxGhaLvehrbR6etzljHAT6amDGV8f+h+8EVhsu4Oyl2T6NlO1mbPbHl1BrQBnO
 mtAItWFAprGwBBxMLmGv6pQ0AL6RGzRV96NdB82qjmApdBZOkCn0CWWw9jPsrOJ2UrwO
 YHPUolWPi88XTh7lARbSNDzOrcq6DrD5RMsW1Fi69tOv+n6Rr9bx/WoTFcpusX2yEOlD
 wD3lnDOB+D6UIdUQjjYqhKvwsMvT1oNaDb9fWPF+4E0s7EkpzDIi4Q3mcfYWmtA5FgFO
 uESgmgay70/mUsGwv6VkvZgBxlaBNN0xe8Zxy39EMZoZj7ur/oUSQTvONLnTtro3UYe0
 Rojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739990758; x=1740595558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JqWEJ+iusIh3WGYUAKhkQ3qSD1adLwMYAmrB8kn95AQ=;
 b=ArI+WueWLy0hDCOn59uEgfNY0TtLYdjaKoEvgqFYUORA2hw3EdMqbHoZMFEUVibEaS
 ygIXFTGKfPw+xWoPiwW2PpfHdyl+qsQRCrNCdz0XsFGsqW1KeSadEzuHcCSRsfnsFW/d
 sp4n2gaekwm3Iq/5xbhbpbU9nU4bD0gnUzG4MqQ6e++V0XpqJm2UoONwNcXpagCXPzrO
 3ia9fY06E8WYhHsW9rEDitGvxbw9qhsZh0My9D+EbM3ehovdZA7GF3hJ5yGTT+SivYLq
 TqhwXkM0YWBimYCyPPOPNvEFmUAcmyitoVAzhpQAgfDxhUGLToSWMh2NhPnpBk2tiByO
 xyaw==
X-Gm-Message-State: AOJu0Yy0VaDMjWumfbZuPLC4d6c15qtyocYCxLrPxRH6Vs7DV15vp1Z2
 xW5Pr2KggvRuMQps4/fs5xA6+1glFkvVRfamudF4x4D6GPhu1+TPDKNFVTBR0KU=
X-Gm-Gg: ASbGnct1eyqu5zO2yvJ2F33XvLmajCofsiEmGZ+Li7i9w3kLv0U/l/Mh0XAaQob+irm
 yvxBVV9fq77CZNHUmu9FOqbxygu4S2qHPtKo4mcLMb1jrTNgxCNM7rkn5y9raJbw9Gh73zJ4XaV
 khpq2EcDxj7oiLDCFqls5mTznq2WisVoC0oR2U1sWZiCgRf5oEHHTFkjP31cSOJ22xjfJyNUCEL
 zG1j0l0XKyrxdiT/8SpE+69YMElZpWS4RCL8ZsHmjiDVjJhg+ZlUEgyIKmu81cTPOmz77hclQM8
 YMystvXLFROSsh7crWazb7LI9gqcyMR+qCtRyOyB9smdpFFedwSfjjUhH6FbzhFLGoeE
X-Google-Smtp-Source: AGHT+IH1PlxVqRHYDVd5IgXmEj3ZllkVTnZxIxUZm4nPU+qB35aUXhq0ZIKteRWTe7Dt7irisRLzVQ==
X-Received: by 2002:a17:902:eb83:b0:220:d078:eb28 with SMTP id
 d9443c01a7336-221711d1730mr77509825ad.48.1739990757676; 
 Wed, 19 Feb 2025 10:45:57 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13ba6285sm12287279a91.48.2025.02.19.10.45.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2025 10:45:57 -0800 (PST)
Date: Wed, 19 Feb 2025 10:45:55 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thierry Herbelot <thierry.herbelot@6wind.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, stable@dpdk.org
Subject: Re: [PATCH] ethdev: fix get_reg_info
Message-ID: <20250219104555.0bc2e0ff@hermes.local>
In-Reply-To: <20250218115828.2107335-1-thierry.herbelot@6wind.com>
References: <20250218115828.2107335-1-thierry.herbelot@6wind.com>
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

On Tue, 18 Feb 2025 12:58:28 +0100
Thierry Herbelot <thierry.herbelot@6wind.com> wrote:

> 'width' and 'offset' are input parameters when dumping the register
> info of an Ethernet device. They should be copied in the new request
> before calling the device callback function.
> 
> Fixes: 083db2ed9e9 ('ethdev: add report of register names and filter')
> Cc: stable@dpdk.org
> 
> Signed-off-by: Thierry Herbelot <thierry.herbelot@6wind.com>

Why does the ethdev code create an on stack temporary variable.
Looks like it only wants to make sure that names element is NULL.

Really should be one function and when extended fields were added
should have used API versioning.
Probably too late now, although rte_eth_dev_get_reg_info_ext()
is an experimental API.
