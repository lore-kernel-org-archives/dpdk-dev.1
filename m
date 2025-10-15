Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3B3CCD193
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 22:17:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A579D4066D;
	Thu, 16 Oct 2025 00:17:08 +0200 (CEST)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by mails.dpdk.org (Postfix) with ESMTP id 292E540273
 for <dev@dpdk.org>; Thu, 16 Oct 2025 00:17:07 +0200 (CEST)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-b4755f37c3eso19389a12.3
 for <dev@dpdk.org>; Wed, 15 Oct 2025 15:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760566626;
 x=1761171426; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2oH2hu8xhRMmInt/T+tAdZFNA6QM/JPDTIEqt8k5llE=;
 b=Kq5HzQNFqP7Oqp8NYlVq3biSrhUxcC33zd/rTO5xm3gzQ5YjGHh7rFSNbObvSp5wRV
 uFxdbfxzc228PFSVdYx4DzV1QZA/Hv9hH11IwoNqAYaUfeAsqJBZHchkeZC8BbMH3gVL
 ueW3Xovb+rayR8pzEDowkDoF10cTouZBsX5ek6hyOQ3GDrEzm8J5y9Ekd2sZ5rd8l2iW
 u7sRdUZtNNH3Bm0JSFNLCgoDPGfYUw5gQCUkG+85VtjnuyCQt/FhW7Ka/RUAbKSBi/YP
 5aU5ZIoVWZ7xY2+/T627C7B+JRxMBe12Vj6392LLb/u53kRSmLfOBDzsu/x1ADqhEw54
 NrxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760566626; x=1761171426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2oH2hu8xhRMmInt/T+tAdZFNA6QM/JPDTIEqt8k5llE=;
 b=kHQvCIF7bd0YnicF5pqG8clZpeAMU/QI/8dAe9aAgLb7V8zZVt74/s1Leyzrs2TJO7
 4TjT1enIi+QC5AvFxCF4Me2rd07/TSlpGAcOqfOA0id0hVoJqO9B9eO8XHuqJshD6eF9
 rz7PRI23GxP4KuqGwq7PDrA/gRmfawcW04uXcSg0b3M2uuZW8EXoJYs/ufhzsTsEjwGX
 fZ6xRwCN+wEpuwWu8FnIizSuidMMd4/8UYoAn/r9oiXFM84q4H7WJMdeoqf/j+e0Cxsm
 giNyoBJ/EHO9ocFSOdSuNv2a75eep1S4B8lx3DowUr+Kkvyaqx79n1IoElWuKkKglKch
 sZSw==
X-Gm-Message-State: AOJu0Yz5oKX9KJ3aCWGKyD0XQX677wsZSr4NL5O4+N7vMjxCFIZVtbis
 GwD7w4IwMv30X4e06oh31ZcUO4vAfp5YYJC7xgCi7ayFS9pfgPoGK0yzESuW3smTT3I=
X-Gm-Gg: ASbGncsNiF/HAtXFPXv9AUrUEkFi//APsZOuDnUQee/C0ZNtUqSZ7Hf5cS74/HZ3pIN
 Mp8P5RAd8BPXlrPvUn9erCFacrAxdlKuTEQLarMrF8JoHOiJCm+uqjcqQEZOH1RVgK3t1RZ+570
 06JwlDrRwN81zS4jCHEGO/kJATv50fAsJt9dhUOL3yxWMqCjNb5/9Ib3MFADLY4j+cyPEuw6owY
 uWaDodV+7lvcXgFpIoj2hZSXN3qO1gZGLZUJcFmzZG/39WwV1DWeRMc5sBxTQgQqjLFTFE7aDf2
 81ogVVuTfI92fIU7IcG97iBkAlYKAGzcfRMYaUnNFlC5U1OIGmxOE0RMAQSJ2pIYesUU8sFzlRW
 i9o+heiGSb/FNwFw+VlMgEqv0HRY+aykky+UV3J+WT/NVOJCak+LdSgcPsWGBBEAxm0zygwMyPC
 HhQbXYZe+oR2EpS8OhLk7Bez+20Tx0nOuAhBmupKcmyojyDh5AhD5X
X-Google-Smtp-Source: AGHT+IGrNWsvA6T1vVN/uaZ//CsgvjJzyOC75v6ityPf1n6E30eW0SM+nWqcVUAoW0mF7LAVhEf7jg==
X-Received: by 2002:a17:903:1b44:b0:258:f033:3ff9 with SMTP id
 d9443c01a7336-29027402c05mr345837645ad.48.1760566626167; 
 Wed, 15 Oct 2025 15:17:06 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29099afbdb5sm6674555ad.104.2025.10.15.15.17.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 15:17:05 -0700 (PDT)
Date: Wed, 15 Oct 2025 15:14:28 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, thomas@monjalon.net
Subject: Re: [PATCH v3 3/7] ethdev: remove queue stats from ethdev stats
 structure
Message-ID: <20251015151428.7c3e0ed3@hermes.local>
In-Reply-To: <20251003110201.1541183-4-bruce.richardson@intel.com>
References: <20250923141207.10403-1-bruce.richardson@intel.com>
 <20251003110201.1541183-1-bruce.richardson@intel.com>
 <20251003110201.1541183-4-bruce.richardson@intel.com>
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

On Fri,  3 Oct 2025 12:01:57 +0100
Bruce Richardson <bruce.richardson@intel.com> wrote:

> +/* retrieve stats, and optionally queue stats from a device.
> + * Note: qstats parameter can be NULL if only port stats are requested.
> + */
> +int eth_stats_qstats_get(uint16_t port_id, struct rte_eth_stats *stats, struct eth_queue_stats *qstats);
> +

Need line break to keep checkpatch happy here.
