Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229F2C02196
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 21:42:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A29C641133;
	Thu,  6 Feb 2025 22:42:49 +0100 (CET)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by mails.dpdk.org (Postfix) with ESMTP id EA30D40EE2
 for <dev@dpdk.org>; Thu,  6 Feb 2025 22:42:48 +0100 (CET)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-21f20666e72so30394105ad.1
 for <dev@dpdk.org>; Thu, 06 Feb 2025 13:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1738878168;
 x=1739482968; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o33Muht/DwEhftmXABDYXIeCSdwYG/QWNul/FYJI1e8=;
 b=WNj3nhA9IB+ytCaeJyp/8UoO8hkagEBOte1xSf0OA58XRPIOMKmbrS6B4/VCQ3nOdg
 M8se7d1LSEAvV9BS+AkfaK1r8q0f4TL4icqM7tESVkRoG74IyeBe60Y9S1Q9oqGUafSS
 rsmEOWxsoHohsS/Gk7nklM0irgTTgj72LQGZY37wnntAgT37nMbjkbPNwAhBA8GrSsRx
 SY9O9fOeXPOBTOXHfjzr+oKF3HUZ057SHC/6xawmMA0uAvAZmsk9DauFSNLdkslZoSFR
 oK29x+V4be2IF6+SATBLpiuei4HtIgdXefHEIK+ukOxg97sL13Ogd9MW1K8HzBxpoD5e
 bcRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738878168; x=1739482968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o33Muht/DwEhftmXABDYXIeCSdwYG/QWNul/FYJI1e8=;
 b=n4oeAh6uOMWpo9IBjxSab+kPzDKQIxvlX8adwoKS3gWComxaUAtlHfqHW7fjd/RA3r
 5qpOe3AezBLROX60CC6nGL7bLqrg8d5ApCOzFOJDd4xHd7IgDNhvsQfzVs3wfGj2BT2k
 offABneHoK8DWdliLM5S6kRFo8wFYgOe2tFXlXmFE31PU8u5bE10/ne2LXkYUPJ3HeVF
 cjvEbmcjs5HMNlkJH0v2QCyZKR5gkrcJM5Q/wRaodTG0Lr82P4NTifMBzF6p4f20UpQY
 BDoXFkYUwp8WSTrRm2lW2KqGqjq6gNlXPP0ikGgrIuji7ZwEl3m8K0j889HlfDvenFUO
 DbVQ==
X-Gm-Message-State: AOJu0Yxq1QmfX8KuHbl4frje64aVkjI2A3EOs4Q5VAWNB/Sm3R06EqFZ
 UFmjtRtoqqCh/X0ytfaRkuNqP7UeAiTbFLbqDLp/EZTMkgw1Mhni5cT4EVbgSRc=
X-Gm-Gg: ASbGnctr9sjXG3EhbvW8dF4i6+ZZMa6OOFSJ8/sFci8RvLkjzFHg1BKjR2gGreCWcb/
 kYU6cYAGAap/o1bjTZHWy6kYb/39nMB6PbI9+3/w0b4femVcjVEmca1ohGjhnHFMvlcBw09wot2
 msBJzfbNcu/avOfUnJ3GhX1vmx6FfiRMfoZ4j1XT++cMOa8S0RFPEcGR4gFz9zV0fOAeGlTBQMH
 kVoW4QeP7DRAfpFu8mplAct5iXkF7TYYlfDUN4gzbjEUg3VcCwRuTWROViodYsj+3rjeALlUsuC
 cbYMF0Qp8gZdqkYKS5bsb2x0AYd1/QBxP3JPzJqEUqUhBVQoQCpaerdyAtHn6KDNzsUp
X-Google-Smtp-Source: AGHT+IEWxpHWDvpbhOvn19pWZ6hivmCB3EhgBJwlD2lP3t/4mGHLw5Pe2rb2Xb50upRhUUDqmo7JAQ==
X-Received: by 2002:a17:902:da90:b0:21e:ff31:531 with SMTP id
 d9443c01a7336-21f4e6e8d6amr13399375ad.22.1738878167826; 
 Thu, 06 Feb 2025 13:42:47 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f363df2b4sm17711685ad.0.2025.02.06.13.42.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 13:42:47 -0800 (PST)
Date: Thu, 6 Feb 2025 13:42:45 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ariel Otilibili <ariel.otilibili@6wind.com>
Cc: dev@dpdk.org, stable@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 David Marchand <david.marchand@redhat.com>, Maryam Tahhan
 <mtahhan@redhat.com>, Ciara Loftus <ciara.loftus@intel.com>
Subject: Re: [PATCH v8 2/2] net/af_xdp: Refactor af_xdp_tx_zc
Message-ID: <20250206134245.0989988f@hermes.local>
In-Reply-To: <20250206204645.1564535-3-ariel.otilibili@6wind.com>
References: <20250116195640.68885-1-ariel.otilibili@6wind.com>
 <20250206204645.1564535-1-ariel.otilibili@6wind.com>
 <20250206204645.1564535-3-ariel.otilibili@6wind.com>
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

On Thu,  6 Feb 2025 21:46:45 +0100
Ariel Otilibili <ariel.otilibili@6wind.com> wrote:

>  
> +static inline struct xdp_desc *
> +reserve_and_fill(struct pkt_tx_queue *txq, struct rte_mbuf *mbuf,
> +		 struct xsk_umem_info *umem, void **pkt_ptr)
> +{
> +	struct xdp_desc *desc = NULL;
> +	uint64_t addr, offset;
> +	uint32_t idx_tx;
> +
> +	if (!xsk_ring_prod__reserve(&txq->tx, 1, &idx_tx))
> +		goto out;
> +
> +	desc = xsk_ring_prod__tx_desc(&txq->tx, idx_tx);
> +	desc->len = mbuf->pkt_len;
> +
> +	addr = (uint64_t)mbuf - (uint64_t)umem->buffer
> +		- umem->mb_pool->header_size;

addr (and the cast of mbuf) should probably be uintptr_t since the
intent is to do calculations with pointers.
