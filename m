Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F67C83F0A
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 16:13:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7702240BA0;
	Wed,  9 Jul 2025 18:13:46 +0200 (CEST)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id 0CFCA40B97
 for <dev@dpdk.org>; Wed,  9 Jul 2025 18:13:45 +0200 (CEST)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-234b9dfb842so948175ad.1
 for <dev@dpdk.org>; Wed, 09 Jul 2025 09:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752077624;
 x=1752682424; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MNzu1pJWkSCFan0flWb6VGpEVfCRS5polmvJhigREVI=;
 b=tNLgMbnnIOQt/zygnmcqhh/CyZdpqILguhJq3vE3xC9sDeBunhkhFc8T/8a5Am3tfp
 d+7e0BEGGfCiafy/NNsEuG1QIhC+UanNxtXIrZx5rlTgkW+zoqB7Skt3ht0laUlDfRsV
 DdrLmIDw56ziiITEJjfwxAF9hv8w0o70JTVUbh5FNEOOiMCIoh86PbvApQ//dH1LekQ2
 J23uiaat1+jS0mxFFbTwiVUruuYUeRW//Z54sbUPGib/WeAdjiwapFHHkWwgRy86/Co8
 XpAz+pzmwyx7/9svUQVpzc7EruJO+3nLZGTDNzjbonr2xUlZv7UU4aWp5+xG958k20L6
 1lLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752077624; x=1752682424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MNzu1pJWkSCFan0flWb6VGpEVfCRS5polmvJhigREVI=;
 b=gUAQtYIUeIz0wutuDJJOWIGHy0JfUmuERpS1WrscAFosvuBtrpBYO2rh1tW0CsmQYA
 f13IItoZxLKYGcXDK5DMjEKF6JiKxuL2h7TsqL41CSY1oZejmPbdGZTCu9ZdaOJDvFhH
 kb3OFtM+ZPTw8Rt900Y/WLmPV4V1FUrBcAbpS8VZOKZlSkVYA/aL5B2FwU75IcGDLTLZ
 gbo6lvd7vPdszRvZAWcGYnNHIrUyVl006lVdattZxuWn8G6nM4AD+2FgSN4BwHQ2R0tw
 0mp4l1oAJDN9D/hsEAGt5l5+UIt2mzQmRE3UvLtrCwNbhYVb3ueoQkEax+/vcVvlpQp6
 igvg==
X-Gm-Message-State: AOJu0YzAry+u255XB1TJJg8wbzGtVJ3MCmVOLpR0hSQ3oEFU44PTVKfw
 szCc3pc5zZHkWZIjK+OZEj8trs8G3DwfA6v5HyOI7On0byM/uZTPZRnstsWFVU/ildbTQUC3qho
 eBNOx
X-Gm-Gg: ASbGncs9LmjnWZxEkwG9+C86aXJctL3ZpPj71VXV+CVt+Jr+kb7+K1BpESGohf3FyJG
 wRQ7T/I/np7bY/iuzT+djD6yx7GPXp4iq7UZvU4urzifnfH5NKWG1IhCenYAidLd2usUnOKkuC9
 lzl/cbWHIrdypxFbXGuCU7jzoc21xdzqDamY5YLI6cMknVJTw7o0X8XfeAUHY1sAur6ZJxN9zVu
 Pb2grBhV2MQHr0bYvPKlJ9s/5dIPLD5pS2FAetiPIhMzj9ShhyY6r0sO0Ilxe6jhKLjDNY/lyzp
 tfaVDMB7o8ZVaLV2jfaIbDmrudNNCQ7Z6ZIjDhL3ZFSUkaWmqsOO21crNd/A42PiCxSoRRiJxLz
 DaVcBy94Nf5ejlElSiWQIuuSjkshXxoSpZTpljXU=
X-Google-Smtp-Source: AGHT+IHAjQaHgEphqUVl/bV1NGELrqEfRJncsqtyb+4xKoWXQ/vTLNCrjw9170dggfyjbAo84oRgQQ==
X-Received: by 2002:a17:902:c402:b0:236:6f5f:cab4 with SMTP id
 d9443c01a7336-23ddb1974a6mr56446935ad.5.1752077624135; 
 Wed, 09 Jul 2025 09:13:44 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c8457b2d9sm139625285ad.161.2025.07.09.09.13.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 09:13:43 -0700 (PDT)
Date: Wed, 9 Jul 2025 09:07:13 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jie Liu <liujie5@linkdatatechnology.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v4 03/14] net/sxe: add tx rx setup and data path
Message-ID: <20250709090713.1596efa9@hermes.local>
In-Reply-To: <20250709084315.9940-3-liujie5@linkdatatechnology.com>
References: <20250707115819.12826-14-liujie5@linkdatatechnology.com>
 <20250709084315.9940-1-liujie5@linkdatatechnology.com>
 <20250709084315.9940-3-liujie5@linkdatatechnology.com>
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

On Wed,  9 Jul 2025 04:43:03 -0400
Jie Liu <liujie5@linkdatatechnology.com> wrote:

> diff --git a/drivers/net/sxe/version.map b/drivers/net/sxe/version.map
> new file mode 100644
> index 0000000000..d010a9b738
> --- /dev/null
> +++ b/drivers/net/sxe/version.map
> @@ -0,0 +1,5 @@
> +EXPERIMENTAL {
> +        global:
> +        rte_pmd_sxe_tx_loopback_set;
> +        local: *;
> +};
> -- 

DPDK has changed to not use version map. See new RTE_EXPORT_SYMBOL macros.

But drivers should not have their own API's if a similar API exists already.
