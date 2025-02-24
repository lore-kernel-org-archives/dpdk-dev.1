Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14920C021A4
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 19:25:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A6B0427B6;
	Mon, 24 Feb 2025 20:25:40 +0100 (CET)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id 07EDE427B6
 for <dev@dpdk.org>; Mon, 24 Feb 2025 20:25:38 +0100 (CET)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-220e6028214so104480335ad.0
 for <dev@dpdk.org>; Mon, 24 Feb 2025 11:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740425137;
 x=1741029937; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d/wXUIl0S3kn8dybOoMvyeaDZ8nTMY1NQWUdCKXFNIM=;
 b=MYZJuupchoOgkCi9jjpBg3M865hR8UnxvxfuK4dyDDmrvqmHCdwqLZGnY5dVfCWdPi
 PMSfadIlINDPvaVkNTfvkvybif6U4FrYgdWXsMcqDZm4xTaoeHDt2zD4tafUD6c5AG7w
 DU9J3DbdZwc4sEwjt+/WE5+TqZEtE//ovFJIuw4GYyL59kYe1ZxVCkBWF90r705Z/U/9
 TkouFX774gXyjXtU6nMu+eWukCc6WEeQhrj6zwUDUoZKHGIBaCNO7Y9oXpBpeLSesDg9
 hu/w4xrWUR2p7RaQHDUMhIC7UJLLIiYqmkq2ime/qJrn6v4r+uhwiZuBmo5rzC/BEoDA
 sRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740425137; x=1741029937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d/wXUIl0S3kn8dybOoMvyeaDZ8nTMY1NQWUdCKXFNIM=;
 b=hTTnNr6WhSuUIrCAiVybTBRdjDPKp+SyVqrd/ZA4Ae12Q3JJs+H/tBO1e6hJ6WvdXX
 jhVP/4cJQxkoD1vPAioxOrO0orIW40wjDYbAU1PPjC548xW6Fs3PGg2au87wsX6k1aex
 Qo8JeVu2nfRlxXL/IrXyzjyitAxee74roIAohP6MobxVIjnPopb5div5wi8ADqlgldmG
 Irt+HJv+x50IKWXRKjJ/QSwG7cXjbOH6ZJHjlTY7mzYRf7j2psV3qGSpuSN4Rvrl3KgH
 8586/vm+oHE9kVW/RZEVcQWzIKma+a3kHDmaA+eXljgkVVUggWO5Td2DBSC3fLjLicln
 fkWQ==
X-Gm-Message-State: AOJu0YzThKPHlXyZ+qV5McaTSGtyAypUGUUf4tg5WnGubTslCkTmI9WV
 3/DLYyYM7kexGvBPOeiefuc9htRgUiXkmb4hpNaA+bQTsHNlipsGyUx3X61JNAw=
X-Gm-Gg: ASbGncsrauLXuJe56UAhMdDzTfRf0oQS3yYqQp8VOy1JtRUd5ILW7jctxiSNL2D8zyl
 eWfMzhSHANDaS7wSBJap1Fz/mUaeJHPTFcoSQyQfWRgvV8/1lGldq1ge4eJeZsW0yv7oX41nple
 9bzcwqe4Kg3aUyVJe+pHxeaS4QfSEjP1o8gDtHQn4QyAqezb/+VzvmwfFsOD2wXPNE4IjXu8pJC
 jsEwTj5p5sDKZ9wie02l/N2zH7ypbD7USSUmUqXvxVOblK3rsBtYsGDCSj0Bb6YbudTBB01w7wM
 3bav/ZUfCi/jNmEQIn5SxNcotCr/dO2xQB4nh/1VvAz4xQc95Bn/fJoDxkU0VBAgiQxFC7HGceX
 U5Vg=
X-Google-Smtp-Source: AGHT+IHzYmLnd84ZupllQg1o2qh+frPogWsqtNL/qu4m6IBX7xP+d5GNw3lRxcRT5oLTB/6bvC1+5g==
X-Received: by 2002:a17:902:d48d:b0:21f:136a:a374 with SMTP id
 d9443c01a7336-221a0025a63mr248622685ad.43.1740425137146; 
 Mon, 24 Feb 2025 11:25:37 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5596115sm184570385ad.258.2025.02.24.11.25.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 11:25:36 -0800 (PST)
Date: Mon, 24 Feb 2025 11:25:34 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ariel Otilibili <ariel.otilibili@6wind.com>
Cc: dev@dpdk.org, stable@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 David Marchand <david.marchand@redhat.com>, Maryam Tahhan
 <mtahhan@redhat.com>, Ciara Loftus <ciara.loftus@intel.com>
Subject: Re: [PATCH v6 2/2] net/af_xdp: Refactor af_xdp_tx_zc
Message-ID: <20250224112534.684c19c6@hermes.local>
In-Reply-To: <20250131231018.2163893-3-ariel.otilibili@6wind.com>
References: <20250116195640.68885-1-ariel.otilibili@6wind.com>
 <20250131231018.2163893-3-ariel.otilibili@6wind.com>
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

On Sat,  1 Feb 2025 00:10:21 +0100
Ariel Otilibili <ariel.otilibili@6wind.com> wrote:

> @ -559,21 +582,12 @@ af_xdp_tx_zc(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
>  		mbuf = bufs[i];
>  
>  		if (mbuf->pool == umem->mb_pool) {
> -			if (!xsk_ring_prod__reserve(&txq->tx, 1, &idx_tx)) {
> +			if (!(desc = reserve_and_fill(txq, mbuf, umem))) {
>  				kick_tx(txq, cq);
> -				if (!xsk_ring_prod__reserve(&txq->tx, 1,
> -							    &idx_tx))
> +				if (!(desc = reserve_and_fill(txq, mbuf, umem)))
>  					goto out;
>  			}

Please avoid doing assignment in a conditional statement, can be error prone.
Surprised checkpatch doesn't complain about it.

Better as:
			desc = reserve_and_fill(txq, mbuf, umem);
			if (!desc) {
				kick_tx(txq, cq);
				desc = reserve_and_fill(txq, mbuf, umem);
				if (!desc)
					goto out;
