Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0EEBCCF9E0
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 16:25:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D164C4021E;
	Fri, 24 Oct 2025 18:25:19 +0200 (CEST)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by mails.dpdk.org (Postfix) with ESMTP id 6E96E40151
 for <dev@dpdk.org>; Fri, 24 Oct 2025 18:25:18 +0200 (CEST)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-781206cce18so2409980b3a.0
 for <dev@dpdk.org>; Fri, 24 Oct 2025 09:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761323117;
 x=1761927917; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YXFg7+HPs8UMBPbLO/Ypu56hizKq2S/ghiv1gM1D8rE=;
 b=Lm7foLy5fTSi6/J1lKgFRdeAP8VTY6wWiaiysFqIvsFEX8jvxiOoxAurd5q5W1wV7P
 8Oq8PeBWzBkRAC9oI/HMjitLQTgawEbabsbMwA72LXETXwxNmwjkLQdDYfJGW+7o4V6F
 O4VmZGX/gBFeCQt1F6IdMCOWLsLhLhTGYi5q1A3nLNpibIINAyYVGzvkLQsluVNPGeAU
 tuy0pOo8wZHAFqJJ4S+mlvHHKsBclWbX9MML56+zflX5Jm0SdbcpLpUqr74aYkeah17y
 ujI0cmS/EJXPOMnQGjDSp7WKbvZqLlDD+PI5LZYNG6ETDylOjMD5AA6dOFcK1A9rKBav
 /wOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761323117; x=1761927917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YXFg7+HPs8UMBPbLO/Ypu56hizKq2S/ghiv1gM1D8rE=;
 b=HnvYunAI0uYq/rld/JcN5NAoz63+34TCT+VsR5eYB0/2AdRzH/BpFJ29W0a3F4SO5L
 5PtaDsKtG6rgoXh66Q9Y0zyPpj0lL4XCfzGD91FVNeqm28hmHzj8FYklpsGc84NVU/y8
 sNdV1IB6pKwqmuzVUJ01ZqTDQLYOVPr5SKLZcP0KQDZNm98jAyKD8S6MKHRw7MVQBjSH
 d6nNNufJeEbtGYFZtGG7NlKlFuRjiigxUyDtsJds7jym5Mkq0WUWrpVNn7t1hlJEejrA
 u1V29ofWKQyQq8vOcKQah9XaGCfMuFulEUM4GWqKq1f3wN68nnTZaJtRRXmQv4PLy6JQ
 4c3Q==
X-Gm-Message-State: AOJu0YwimWTNgC91iP9oDzankoXCpjXunixTJfUKTxBrzWOiH6yDsFKn
 8O4XGgv0p+Epx7PmOp3Z2mnxm2ab06U1uYpihqL6Qw2Q9125sYGjWqLAlzLW/R1s9NM=
X-Gm-Gg: ASbGncsHg336+XMFSXEp+hlm8tRweRHAs2d3k6JN9SLg42vUL+aEmOejZbS5N+41ub3
 cas6zgOiByvRNN5kymRkcOd+gVuDeZMzarH+jNA3kqM1rdAKXEwDM7X/EX2FKtrBWCCicG3Jom+
 9wQzzX7g1OqxEH+xw8iXOsEsMNActCBDII1/hROUkmT32MMKQR2FonOscF9DcZX0hil/S6YPjJW
 eU38+RZYtYhOlNnRbJvx/Fd84gaiN1SqxTsoiwyplPROHamUZXaLlyT+xQtqlFh3iPn7UnEuY5p
 CdDAuU57QgSbJ7K6hLnDw8kfIpo2sjL8Sgh+KKNWAf1DjlJOy71HpSwArkdiBAeVnDNEwX08FV+
 +IijKJNszHrAWtwQItZ5PwBfievo8sBy3N9PjJavxY0dvlsEqK6wrh+aOpDp1puiAMFkL3cWgXE
 a7H+xNeR0QqPM5MN1tC0Z1JneTAEm6bnc7h4oq1QLpnTtZ
X-Google-Smtp-Source: AGHT+IErthOj0ozGW4t8JlMVYEh2LdJ/g/fRnBvMkzEmCV7gGEhDTjTauRSpoiQYVu1JvjY3gXBjRQ==
X-Received: by 2002:a05:6a00:b8a:b0:781:1110:f175 with SMTP id
 d2e1a72fcca58-7a284e102famr3535508b3a.14.1761323117458; 
 Fri, 24 Oct 2025 09:25:17 -0700 (PDT)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a274bb22f6sm6361342b3a.56.2025.10.24.09.25.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 09:25:17 -0700 (PDT)
Date: Fri, 24 Oct 2025 09:25:14 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Wencheng Li <liwencheng@phytium.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v10 1/3] net/macb: add new poll mode driver
Message-ID: <20251024092514.3a62ff89@phoenix>
In-Reply-To: <1755664389-9412-1-git-send-email-liwencheng@phytium.com.cn>
References: <1749200770-53411-1-git-send-email-liwencheng@phytium.com.cn>
 <1755664389-9412-1-git-send-email-liwencheng@phytium.com.cn>
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

On Wed, 20 Aug 2025 04:33:09 +0000
Wencheng Li <liwencheng@phytium.com.cn> wrote:

> +int __rte_cold macb_eth_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
> +							uint16_t nb_desc, unsigned int socket_id,
> +							const struct rte_eth_rxconf *rx_conf,
> +							struct rte_mempool *mp)
> +{

Please take off __rte_cold except where necessary; in later followups.

It is meant for special cases (like rte_log) where code that calls that
function should be less favored and does not need speed optimization.
In a driver like this it just is clutter.
