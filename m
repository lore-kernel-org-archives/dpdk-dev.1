Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED337C3DA6D
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 May 2025 18:49:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC0CA40666;
	Tue, 20 May 2025 20:49:14 +0200 (CEST)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com
 [209.85.219.44]) by mails.dpdk.org (Postfix) with ESMTP id C00EF4064C
 for <dev@dpdk.org>; Tue, 20 May 2025 20:49:12 +0200 (CEST)
Received: by mail-qv1-f44.google.com with SMTP id
 6a1803df08f44-6f0cfbe2042so61188476d6.1
 for <dev@dpdk.org>; Tue, 20 May 2025 11:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1747766952;
 x=1748371752; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1MxpF+qVXF74O6OfkxWoSgI6Ch+StrrkW+RPRIBWL0s=;
 b=gbEDYQTpkeqwsaESXmTMc9fCJyy9EFHDyZrDsMvxsYQaYodwCw4weSOzNz+3lGxUUL
 ba9pVVfst1Ldofnm2d+AW4C8nlTUG4qPVozgxoIpSA/pUPkGzkfwVNKC9DYehv3GgexG
 EaaDb1+AZ3SgSjOybjH0WpE+W/OyIfD+kdlvWQtox3HjH+Ng33bWKizwIjh6kCc8RdBf
 gvqsP9yTEqYlFuQjagN5/8J4Vkh+ABf0Hvna8iBMG2C1bt/xTmaW7eQQPFaAuC3oR2wi
 ixb/hVVHyWXPfLf5r5mnr2r8yqnxlMRBs4cn2PMhUA++OElsk6vZ56V02J1q0GwqUlui
 LNsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747766952; x=1748371752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1MxpF+qVXF74O6OfkxWoSgI6Ch+StrrkW+RPRIBWL0s=;
 b=aPdnmyXNTFjJIa1yRNMOYPRPZolj1NtIydhP2bvxeXRXTnGNev6mtpJq74pEzxpIiM
 zv/1nOGEJ9W0jx3Zojt0Qj3PsaFblAeP2NF0gmKXSt0a5ki2v3hZmSmw7sIaXY6T9mPE
 7MKdxxOgGoyuDXQj7kbbcVeT0CX4EYcX627disnbJXHiFHVTHLzd4/5zydzqWRsjHz13
 pgjp176QHXpPrxqBs0BMcjc1TcOQDjTGSNjZCtUdbLBUcWjM/nQolvPoNTZagoWjYChR
 OoG8ObZONn+xR/hQGcI/uInnAixlS9bBQdnDmaCtyal1xT4NPVodx9vwcI5zg+tJUP9a
 IgSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjcMTm11dZ7aVwKIJDvBaLuIn+CStrUe5l0CgEsRTsVP+PuJNbGzLaxQA4ki2WAhArck8=@dpdk.org
X-Gm-Message-State: AOJu0YygfVhEggUky2BgqPfTUXSJ6ZxzZMnP0ImwrplpOk3i/lrmwJej
 ifJZE6obGGyzewQjJX7Bnw0yClwHUMZ4IndmlkpLE/XcChvwNPmmFlQ4umgM0pTGz9c=
X-Gm-Gg: ASbGncs8gY9hRoyZKuJ14xDRrtKS4hIVlWgBnV17OMysKWtXr1KZoEvz75vNKxOAjvy
 8WCBd8u1XaU92hVZOV7eapVj4T0hAe+MuyNrQL9EIy3F5t1NoRgjT0PfbyKnqPdBYNFyTpfC5f9
 eZ2D/Gh57XbBHvTHykWhKQ+SzKG7sR3FXvx51dkbArImQ94XzpOF06O3lPSxoQcu0xLSuMuwupn
 gIGKlqJX+aWPkZisWIWRrpCiSW9cmxqWaODoxdrEiWeFCrSWGxb2Aund5VdCwzZo8+5QK7gsssg
 eMQbpzUkc4KhzLIqzAfCUKaiiRCPUYwO575YjpAWpUYlIZWXHZ/LYTn6rQc61ZswzKJhFMnIz5y
 SgbyFJl4OmQHRZUCAsfZH6cNF5jsl
X-Google-Smtp-Source: AGHT+IGp8MLr80Vul/LcDiI7bsDnXa1mJLS/HDNGDErdwJjeB2SdRIf9puCuOx5TijaxlR5got+cVQ==
X-Received: by 2002:a05:6214:2a88:b0:6f5:4711:2a6f with SMTP id
 6a1803df08f44-6f8b123c004mr273560796d6.4.1747766951891; 
 Tue, 20 May 2025 11:49:11 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6f8b0898f66sm75470556d6.27.2025.05.20.11.49.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 11:49:11 -0700 (PDT)
Date: Tue, 20 May 2025 11:49:04 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Yogev Chaimovich <yogev@cgstowernetworks.com>
Cc: "dsosnowski@nvidia.com" <dsosnowski@nvidia.com>,
 "viacheslavo@nvidia.com" <viacheslavo@nvidia.com>, "bingz@nvidia.com"
 <bingz@nvidia.com>, "orika@nvidia.com" <orika@nvidia.com>,
 "suanmingm@nvidia.com" <suanmingm@nvidia.com>, "matan@nvidia.com"
 <matan@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH] net/mlx5: fix transceiver warning when not exist
Message-ID: <20250520114904.6570827f@hermes.local>
In-Reply-To: <DU2PR09MB5486574FE72A43A09A323DCDD68E2@DU2PR09MB5486.eurprd09.prod.outlook.com>
References: <DU2PR09MB5486574FE72A43A09A323DCDD68E2@DU2PR09MB5486.eurprd09.prod.outlook.com>
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

On Mon, 5 May 2025 12:14:51 +0000
Yogev Chaimovich <yogev@cgstowernetworks.com> wrote:

> From ffe666291bc531b89620cc28a7b45fa209700f35 Mon Sep 17 00:00:00 2001
> From: yogev <yogev@cgstowernetworks.com>
> Date: Sun, 4 May 2025 23:11:46 +0300
> Subject: [PATCH] net/mlx5: fix transceiver warning when not exist
> 
> In case no transceiver exist when trying to get the transceiver's info
> There should not be an error message from the library.
> The caller may print an appropriate error message using the relevant rte_errno if required.
> 
> Signed-off-by: yogev <yogev@cgstowernetworks.com>

Signed off by is a legal requirement and must use your full name.
As in:
   Signed-off-by: Yogev Chaimovich <yogev@cgstowernetworks.com>
