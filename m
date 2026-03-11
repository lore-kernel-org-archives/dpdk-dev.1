Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A75112584F
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Mar 2026 16:32:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F6CB40FDE;
	Wed, 11 Mar 2026 17:32:20 +0100 (CET)
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com
 [209.85.161.47]) by mails.dpdk.org (Postfix) with ESMTP id 6BCE4410D4
 for <dev@dpdk.org>; Wed, 11 Mar 2026 17:32:19 +0100 (CET)
Received: by mail-oo1-f47.google.com with SMTP id
 006d021491bc7-67badf2d5b6so44416eaf.2
 for <dev@dpdk.org>; Wed, 11 Mar 2026 09:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773246738;
 x=1773851538; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m7ueabZ2fW4EHBYYMziTAn5PufFBQ81OVhla/J72Cac=;
 b=FmE9+demPsi8vsjxsybuUJwFQvMusPf4iVGEiqjzOYbtEj2Fuh75BKvHO+zOj1zFD6
 aw+1F+xadxTcWYmc0QdzKsRk5W0IORaJ0SAQQ8nn1mkzQ+JMWUkCcP+KMWnZMCv7RdSx
 wLc3iJepJs25dSB7gZDtG6MNBTT2oU8wh0QNxhAcophUJ1mxYSPtbsm0DzLeZe3VY6Fg
 AqSouaVCgK8J0oyZZTEjW3GwIjpnFeAtOX6Iw+bWJcZ59YGgW27bGEo4Yb/6xVmypM0Y
 doWEdF5LrXhyWARAsy9CTh/qcQA9KDrRZL25udDz0gMXtuw5LrSCKX1Yd0hpb0NSPYGn
 hptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773246738; x=1773851538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m7ueabZ2fW4EHBYYMziTAn5PufFBQ81OVhla/J72Cac=;
 b=w0Q4BWDtOye1G26PrVvtrsXehJA4JpPR38XurMY6/YF/LMMr6kFBcZT7qIoSHzFkjc
 h+r+X+d1OMQBewpLDxHl47pi1CvdEKD+Ylw/Ytqtj487Y9OLas2XNrCKNPQL9G75s5NC
 epGO4SruNkXErtTylKuvf3WDUyeNe7PjzmlLgS9jE2h8ipRFEWaNfprQNF/nrQGLqpPM
 j4ZkZuDCpEcAB8/ozffXdciFAN6WZ9xiQzr5cf1GE79EEB7C/M2sKGWDLLwzLizH1qXi
 ROh5v3CadqDGFxiFUkCLFK+HjTx/1w8Pj7EiJYgXdI6WQIYxgtOaS4LhtWhBjTTplBal
 zHVg==
X-Gm-Message-State: AOJu0Yz4b/91Xe2CxzoF1W97ZbjyllRLkPzDUlb0ZdYgZY3Tu2xjio3Q
 iEjtdCG0NuR7eXKOW6dOMIYtlSuS03/N2WU+xaIxerjTAShIZypxWyvH+dbDxw8gdhU=
X-Gm-Gg: ATEYQzz4hKoVaSdWWPqt0p0Rd3LajgqXL71FUjm8vZQY4kLUN/iqZMHLZqFPKrWqG0A
 MRjeNPwMZu0Sd6JvE4tP69oj3sXzZAZbStNKw9jN/QdmuDqi8pok8gjH4QnHUxqwl+B1wZ+/V0y
 20gqxExQY2KZzMiwqOCORiSnSW7pZKT+K8NPdR8E4MVea4arbbTyiOVko7XE1TVvfErmSF2kE+R
 3z0W5Ay8RYTIzfhoRRkFKSPNFyLEWDAQgEzf1z8FLTfm3+PJwXUFTT2SYST8SYNLDGRRjABbbeJ
 Xs1Ta3ud4ae758wx5JNNZddRSOTngOD6jHee45DvzgUjqXiCOkOrdrcjRNVAZ2ddQGYYQmmTRGd
 usRYq228zUxZDMHvJOmtrLSMS7A0HEx0JyM6UskBFcCo/lWgKmd64ytErhTyfRvg4QcwW5rvtPu
 l3nz1XuvPZHXln1IrxVUZ8RCm6ahsbAJ0oiy0=
X-Received: by 2002:a05:6820:220a:b0:67b:baca:a49b with SMTP id
 006d021491bc7-67bc8a422aemr1899964eaf.67.1773246738406; 
 Wed, 11 Mar 2026 09:32:18 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67bc93061f2sm1686372eaf.10.2026.03.11.09.32.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 09:32:18 -0700 (PDT)
Date: Wed, 11 Mar 2026 09:26:48 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Vincent Jardin <vjardin@free.fr>
Cc: dev@dpdk.org, rasland@nvidia.com, thomas@monjalon.net,
 andrew.rybchenko@oktetlabs.ru, dsosnowski@nvidia.com,
 viacheslavo@nvidia.com, bingz@nvidia.com, orika@nvidia.com,
 suanmingm@nvidia.com, matan@nvidia.com
Subject: Re: [PATCH v2 08/10] ethdev: add getter for per-queue Tx rate limit
Message-ID: <20260311092648.7f22eb67@phoenix.local>
In-Reply-To: <20260310232653.2935764-9-vjardin@free.fr>
References: <20260310092014.2762894-1-vjardin@free.fr>
 <20260310232653.2935764-1-vjardin@free.fr>
 <20260310232653.2935764-9-vjardin@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Wed, 11 Mar 2026 00:26:51 +0100
Vincent Jardin <vjardin@free.fr> wrote:

> The existing rte_eth_set_queue_rate_limit() API allows setting a
> per-queue Tx rate but provides no way to read it back. Applications
> such as grout are forced to maintain a shadow copy of the rate to
> be able to report it.
>=20
> Add rte_eth_get_queue_rate_limit() as the symmetric getter, following
> the established DPDK pattern (e.g. rte_eth_dev_set_mtu/get_mtu,
> rte_eth_dev_set_vlan_offload/get_vlan_offload).
>=20
> This adds:
> - eth_get_queue_rate_limit_t driver callback in ethdev_driver.h
> - rte_eth_get_queue_rate_limit() public experimental API (26.07)
> - mlx5 PMD implementation reading from the existing per-queue
>   rate_mbps tracking field
>=20
> Signed-off-by: Vincent Jardin <vjardin@free.fr>

A couple of observations about this new API.

1. The queue index validation is duplicated in both ethdev and mlx5
driver. Since this is a new API, the ethdev layer should be the single place
that validates queue_idx < nb_tx_queues and rejects NULL output
pointers =E2=80=94 the driver callbacks should be able to assume these
preconditions are met. The same applies to the existing
mlx5_set_queue_rate_limit() which re-checks bounds that
rte_eth_set_queue_rate_limit() already validates. Remove the redundant
checks from the driver.

2. The new rte_eth_get_queue_rate_limit() API uses uint32_t for the
rate. Since this is a brand-new experimental API with no backward
compatibility constraint, use uint64_t for the rate value to
accommodate future devices with rates exceeding 4 Gbps. This applies to
both the getter and the setter callback =E2=80=94 adding a new getter that
already needs a type change next year defeats the purpose of getting
the API right now.

Surprising to me, that AI review found nits, but totally missed
several architectural issues.

