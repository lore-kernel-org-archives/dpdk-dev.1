Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BD1CA101F
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Sep 2025 15:29:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 658AD4066E;
	Fri, 12 Sep 2025 17:29:55 +0200 (CEST)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com
 [209.85.160.171])
 by mails.dpdk.org (Postfix) with ESMTP id 76FA44065E
 for <dev@dpdk.org>; Fri, 12 Sep 2025 17:29:53 +0200 (CEST)
Received: by mail-qt1-f171.google.com with SMTP id
 d75a77b69052e-4b3415bfb26so15726651cf.3
 for <dev@dpdk.org>; Fri, 12 Sep 2025 08:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1757690993;
 x=1758295793; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JxaE98WuKSUpJIRr17pMRkGJmEGX1W4SWfUOiByRYgA=;
 b=E336rCUqO04flX7J3gqFCWJI1aDpIHyJ6L7VhxNAWp/pmZdAZFW6QI6TtFTUeBhYgm
 PL8tD8DjiJZNCowpuP0gRLoaq6IHamLDbb8SD1KoWYX+RwDlSEkxa9+yK3lpRzqhb2W3
 2icN2mHHKmNjV3xyqIyzC94F7YqOTpm3EVu29jQPv0J4BV58AL3iQAZR5SZy0xpEkPx0
 xVmK45lyjw59+KD6ZOhDf33NL9Yv4FWzmOj70g+oHTN9uMXwxHNF4Hgf2onI2BVAq7+U
 eRxJ4kvVO/zRFhd/ivtQ4wtG6sZRykdKueEFcwS8VOCyBJWJkPTeLFwAYbCZrTiC06xA
 yEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757690993; x=1758295793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JxaE98WuKSUpJIRr17pMRkGJmEGX1W4SWfUOiByRYgA=;
 b=FZEs5bF1nGR4vhWw6jKYi5E5rD6orD7SJxURu9PgHReLmfI19yPcO3vJzhfBD4prD3
 bdD1K6D1t7u/i/HCKXfMegjdqG7OSD4nKfXFUafh8n1Eb5bQ/vkZTQ0jR3cgc6Vi+neM
 yb/+9kfbx7QmQx5B9+SnLgfCksE5RLv543HeA16XqroLzSU3Xv3xLMSfTdEt8hCbRwvh
 B/HEC8k6z0Ivqr57wHjaAHKpjK5cdI6WO2KYHpc7RaYaASWfWaXfjhgDC+onehRJitfv
 t6Bcmn4brFjNx4BuibSdw5zM9bblCc/zfnH4h2SRJALqfM0ESu/AO63Ks1YOC7dp45t0
 Tm+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWB+cCYUUNfKwi9bpeWf8PPN6AMAW+H2Eo6YXKu0u7ftN6D77Wdy3e1S2/b2TNsn/o/pJ4=@dpdk.org
X-Gm-Message-State: AOJu0Yzg+9k0CegLm/CqR6rT54Eixa4DpxdZOxjxv6NBIxU2wp59eO4M
 t6oP6n3H6XjF1WNZQA5F82vS7z3v471SE7+DyZu5hDNBIJGBuZhEXUeVDoZJDSAy79o=
X-Gm-Gg: ASbGnctsMsF/rUVF1WS7YUTzd/da+ciGO9vME7SqnJusj824RAQMGWzqqC+msvHDohk
 x39WnwTHN0Y0mPOM1hymOwENfSy3jULfMvyCF1isQSeTomW892J2jDgWlQOE+TATS1fTQQkgxNw
 ucrX2cw3LXNOvKKluGb1HxWlZ6yZbe7/s12gk6wOAhQgWog98JiYDsv9M469DQ3PXdZ3j8YlXbf
 s6qQkWAntTpRdDUXfxxzkfxVPi37s5j0MIMQunrPNJ+/qhdpLEP+SuU07e2fykWqeakp8faK8tv
 tjoFO4xZI1yjTk1SWdjwhgR8SR9JgmJDTumU6xpMqrpzPwQJhNwJXUrkPDCWzyvaDq0Vquvo+5r
 WfmnvF7xcmbTqci5WCw1czII/7nLMbZm4uxpPVI9PYyVOtdIIbeUmzZKBkjg8sqLjW7EpCTMg+h
 PIAhOpZhdPnXhbblW0szpa
X-Google-Smtp-Source: AGHT+IGeeS+vIoN0052W278L2/W27wIG4tUgYy26347RZmYZefih6rkUWBNGL+COFI+n5wTd+ufA8g==
X-Received: by 2002:ac8:7f8c:0:b0:4b5:ed9d:7bc1 with SMTP id
 d75a77b69052e-4b77cf9843amr37165601cf.1.1757690992463; 
 Fri, 12 Sep 2025 08:29:52 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b639dab685sm26167991cf.26.2025.09.12.08.29.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Sep 2025 08:29:52 -0700 (PDT)
Date: Fri, 12 Sep 2025 08:29:47 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Kerem Aksu <kerem.aksu@i2i-systems.com>
Cc: thomas@monjalon.net, linville@tuxdriver.com, dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH v2] net/af_packet: fix crash in secondary process
Message-ID: <20250912082947.6eaf4cf0@hermes.local>
In-Reply-To: <20250912113525.396070-1-kerem.aksu@i2i-systems.com>
References: <20250912084758.354208-1-kerem.aksu@i2i-systems.com>
 <20250912113525.396070-1-kerem.aksu@i2i-systems.com>
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

On Fri, 12 Sep 2025 14:35:25 +0300
Kerem Aksu <kerem.aksu@i2i-systems.com> wrote:

> dumpcap crashes when trying to capture from af_packet devices. This is
> caused by allocating interface name with
> strdup (i.e. malloc). Interface name is not accessible from secondary
> process and causes segmentation fault. Use rte_malloc instead of
> strdup to fix the issue.
> 
> Bugzilla ID: 1786
> Fixes: 1b93c2aa81b4 ("net/af_packet: add interface name to internals")
> Cc: stable@dpdk.org
> 
> Reported-by: Kerem Aksu <kerem.aksu@i2i-systems.com>
> Signed-off-by: Kerem Aksu <kerem.aksu@i2i-systems.com>

Queued to next-net
