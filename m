Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8B4C79FA0
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Sep 2026 17:17:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 399DD40A6C;
	Mon,  7 Sep 2026 19:17:54 +0200 (CEST)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id 049C5402DE
 for <dev@dpdk.org>; Mon,  7 Sep 2026 19:17:53 +0200 (CEST)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2cace91f112so30474515ad.0
 for <dev@dpdk.org>; Mon, 07 Sep 2026 10:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788801472;
 x=1789406272; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3o92QB3zNXO6kWeD9U7FxhtG6j7UPiehGQuBQkucbnE=;
 b=xVR7TmdOjZC61lajXQCIiLbnS2OXmnCxVIvyWPvEM5FYum56yWUhD4EKmej82u/13Y
 kbm+0gtqNrxgbWjwj1j6PPkb1bQHnfpIwJ5L3+9PYobAsy5RF9z737Q/sMrLWjUCUOaX
 Eg5BXh+Ci3SYmLUdARdvR91lgoiLBpUWNO+cpN008eG+92pBMvZJWkfrhlcscwrXPHd/
 z7smqU6Rh3y+unasdVbzydA+od8xXnohzF+tLCIxn1VR/+Jqp9AZB6B7/Hga9QTxWuEw
 +g9apzishc5U4TtJdIY5Yy2tM8wOBafIoDHiYvWYEXXBKge7AKClZmBrXJpsmaJxCQsv
 heEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788801472; x=1789406272;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3o92QB3zNXO6kWeD9U7FxhtG6j7UPiehGQuBQkucbnE=;
 b=pbj+pkRQ5VikYvz3JfqWe7Yi9cMhoQj7GLKNr1iPHpBJUD7PdXfAEZicqNqM50cwkT
 j7X3pWmj/SQC4rUS85J8wICf7oiz5jgIJIGjGAACoMDwtWrvUd27gCHEaIlq9xQOQBg6
 /DmbgFMwB72yuQn8aRvrUssdSZBKF19y7eYXtwgnllajG317POJnRX0S8ayToeWkYJRA
 Jz9LGjwKA/3GWvgpMIrdpt1q4aghodkS+KhsRcmkQe+Lbiz/8Qr89VdMQaU+gr2YghNy
 KV4IcfOrFxlsuBpd4sSD+HFeEFV3cM/J4ji/A/Ti0MBXxL1xRDr96ZrT/G/2SslbXTOP
 R8Pw==
X-Gm-Message-State: AFuF++lTxL/d/6CBvKg2ngiUGzZL5ky7D8KdwNbdt3AaLkUlWAugSged
 FQu/r2RAN1A0lUsRjKVdVL3y/FEfoJSUS3yRYy7QaPPjJjFkR4g3bZ7DR9LAI0PYYN8=
X-Gm-Gg: AYBFou0/uLLXVzNQf11/obVnGkmD/DU1ZjgvYiW3pedWX2wk/k7IgPh7K/g24fhNkGx
 qJuUIa6cc+RpW2N/d4VfpeGiAlCF8CmlvxsgtS1x3rjm2eGgQNbkOeAku8p11Nz/xiiUYq0kR1T
 j7aspwsSMcuerW4Sf4/b79OmP+78LoUIS5o4UywBjMxNkg/ChOjnKCg2GNEpKO/gTnn7sryHTJG
 7FO9s3LJMlIQoW70TcUSfMHAdVwKd/4NQ2xy9tRSGJIJZzVFWKKZ2J6wxcAkYBc9Y4CVSh+7nXt
 yDZmXcEwBND7Xukv73sdbNhl5B1WnMqhjdCcTTBrmM2YK49k665D/F3kpDdbAkbBZK12bDmZd6z
 d35yBnI7uZP1R54U/3eHmpuCmQnQzPql/CjCcRg6OMwtWrXc46N2ftoYuZ1ZdTpuoT4o3Rlv6Mb
 9U8oO9i+SQ26gMPZXljcn54nT4b3lNyKrP1boBCXsUPJ3++7i+OgqWXhoHf9dgg3H2lIFeHZrIk
 QK9BOJDStXK6AgiS+3mRX3dqmZCfw==
X-Received: by 2002:a17:90a:ec8d:b0:37d:f983:7b5 with SMTP id
 98e67ed59e1d1-39b26101c08mr35444673a91.9.1788801472059; 
 Mon, 07 Sep 2026 10:17:52 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b4b72f62esm15756655a91.5.2026.09.07.10.17.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 10:17:51 -0700 (PDT)
Date: Mon, 7 Sep 2026 10:17:42 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Kishore Padmanabha <kishore.padmanabha@broadcom.com>, Ajit
 Khaparde <ajit.khaparde@broadcom.com>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH v2 2/2] net/bnxt: fix MAC address removal
Message-ID: <20260907101742.180b035c@phoenix.local>
In-Reply-To: <20260907111724.3043887-2-david.marchand@redhat.com>
References: <20260904121651.2254684-1-david.marchand@redhat.com>
 <20260907111724.3043887-1-david.marchand@redhat.com>
 <20260907111724.3043887-2-david.marchand@redhat.com>
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

On Mon,  7 Sep 2026 13:17:24 +0200
David Marchand <david.marchand@redhat.com> wrote:

> diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
> index c6f566c214..d37e2d16c9 100644
> --- a/drivers/net/bnxt/bnxt_ethdev.c
> +++ b/drivers/net/bnxt/bnxt_ethdev.c
> @@ -2019,14 +2019,21 @@ static void bnxt_mac_addr_remove_op(struct rte_eth_dev *eth_dev,
>  				    uint32_t index)
>  {
>  	struct bnxt *bp = eth_dev->data->dev_private;
> -	uint64_t pool_mask = eth_dev->data->mac_pool_sel[index];
> +	uint64_t pool_mask;
>  	struct bnxt_vnic_info *vnic;
>  	struct bnxt_filter_info *filter, *temp_filter;
>  	uint32_t i;
> +	bool vmdq;
>  
>  	if (is_bnxt_in_error(bp))
>  		return;
>  
> +	vmdq = (eth_dev->data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_VMDQ_FLAG) != 0;
> +	if (!vmdq)
> +		pool_mask = 1;
> +	else
> +		pool_mask = eth_dev->data->mac_pool_sel[index];
> +

Why bother with the vmdq temporary at all here?
	if (eth_dev->data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_VMDQ_FLAG)
		pool_mask = 1;
	else
		pool_mask = eth_dev->data->mac_pool_sel[index];

Or use ternary if you want here.
