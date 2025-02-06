Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5EFEC02192
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 01:03:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 71E65402A0;
	Thu,  6 Feb 2025 02:03:28 +0100 (CET)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id 768564029E
 for <dev@dpdk.org>; Thu,  6 Feb 2025 02:03:26 +0100 (CET)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-219f8263ae0so8468365ad.0
 for <dev@dpdk.org>; Wed, 05 Feb 2025 17:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1738803805;
 x=1739408605; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aK4prp9uaO0gaujhtiwTZk+7Y5gIQ0po6LM2wfq7jfA=;
 b=wb8qvLD4B0xpKrmycwNV7izY5KzH5zkZ7aYrEqa0/Dkj6mD+WOTzI3oEPaqyVgotG1
 9bz9y6NbIYuRqmT2jkWTgUqLSQqEe/lYKTB5HN63psBCmDVJYnn5REyjXxGgz9ZGINlu
 H4PN0NtA3e82affUSf/Dz01vjGZO5dootS7mOOOANW5RBqzo3IqUVCIt4Kx+ME9caHh4
 t/cmSlSMQHHbkpksBVqJJgZHiEZRjP79v1vvjFP5md81lK0COGSovfemDUE84FUVjxer
 LCd4rmnLIpUsi2i71aIXOpbZNdiyknKdibxomh0YP19SWbcUao60KQLS4q0QBZ+0aJNX
 WEeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738803805; x=1739408605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aK4prp9uaO0gaujhtiwTZk+7Y5gIQ0po6LM2wfq7jfA=;
 b=Z9m8UO8AcTpC6UkPtyExrv3A1ps526LSHJ0UPhUFs6k1OM6wz8sH3SVIzN20c9zKpN
 aWCtBxjSxemGjkwPKnySnB7PEAkrBSXVIBmfzXsLbmH0oqrNg/IgwxoEPVE7iZ4ciOYc
 FLZK3k/WLbztnUvJ8j2eXt2kbLfY3gKDSBqQSQWnzypJMDLVfIdYDthXEsTPhZbAUByN
 0cd8kOAdezXEGmpgFK9Oq/TMVCUIGhMSRgC3Knu25ZegpuzipzM8kUdsATFQF7BY5wMr
 xBELjVfBz2BvNKchuLjBoaQcSev4fHe0nZt7b1UU1dBhRvS+iJGHuz5O/DY2lZ75dJnN
 PB2w==
X-Gm-Message-State: AOJu0YyJeHGuh2hFrorFuye3EzndwpY0PXriYTEOuSPGgQuLb6ymPCPJ
 MZqGOzgX4+WMdQzfrBVNB91uStw9aEBHLKysfoj/Z/BZ4FPS45YPRGhf5edf7F8=
X-Gm-Gg: ASbGncsrcu+UhuPTZehi7scd+AawiY6XfIBk0kVnpnvThBzjQ8DioXLiGLAQj1yjE+X
 BY9Ye9QvQolaZaCP6TjuM3nXGsH9Fkp5WUJ8uPaQjoTZuvehhnCrLGNgjrmJ8gG/CTsiY9UqdwO
 bv+Uo5QDwKwWh6ludw5+g+r4+KgdRJ2keACvKOeyuFyRfccZmg5EfZOcUw9HKoy9T8bvCfgLlIE
 S33gi4ryk8t00EaBVhcm6IMUN3+98ZbVgvQL1Xiufspso1yyBD3RP15JQFhZQY1OYIcgbxyoG6D
 UebCOttf1DG5VC2bmOPu5j+7uX80f4bvFmFajkA5hb4K+xwLBc/xTzB3vVVTVtPh7KcX
X-Google-Smtp-Source: AGHT+IF1KuENiRRqyFd0qwS4GbNiAjVIgicUrSAg5DuUhXOgM40gSzYZHRkzPVlQhQvIpKzA9TvCAA==
X-Received: by 2002:a17:902:ce03:b0:216:39fa:5cb4 with SMTP id
 d9443c01a7336-21f17e6ff76mr90024305ad.25.1738803805385; 
 Wed, 05 Feb 2025 17:03:25 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f365446d7sm366235ad.82.2025.02.05.17.03.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 17:03:25 -0800 (PST)
Date: Wed, 5 Feb 2025 17:03:23 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Shani Peretz <shperetz@nvidia.com>
Cc: <dev@dpdk.org>, "Tyler Retzlaff" <roretzla@linux.microsoft.com>
Subject: Re: [PATCH v5 3/4] app/test: add tests to find devices
Message-ID: <20250205170323.026210bb@hermes.local>
In-Reply-To: <20250206000838.23428-4-shperetz@nvidia.com>
References: <20250129085416.226718-1-shperetz@nvidia.com>
 <20250206000838.23428-1-shperetz@nvidia.com>
 <20250206000838.23428-4-shperetz@nvidia.com>
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

On Thu, 6 Feb 2025 02:08:37 +0200
Shani Peretz <shperetz@nvidia.com> wrote:

> +static struct rte_device *
> +create_pci_dev(const char *name)
> +{
> +	int port_id;
> +	struct rte_ether_addr mac_addr = {
> +		.addr_bytes = {
> +				0x00, 0xFF, 0x00, 0xFF, 0x00, 0x00
> +			}
> +		};
> +
> +	char pmd_name[RTE_ETH_NAME_MAX_LEN];

Why hardcode a MAC address, which could lead to future issues.
Instead use rte_eth_random_addr().
