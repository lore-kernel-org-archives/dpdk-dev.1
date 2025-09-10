Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D1FCA0FED
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Sep 2025 17:34:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A22EB40659;
	Wed, 10 Sep 2025 19:34:12 +0200 (CEST)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com
 [209.85.160.178])
 by mails.dpdk.org (Postfix) with ESMTP id A608740649
 for <dev@dpdk.org>; Wed, 10 Sep 2025 19:34:11 +0200 (CEST)
Received: by mail-qt1-f178.google.com with SMTP id
 d75a77b69052e-4b3415bfb26so50786951cf.3
 for <dev@dpdk.org>; Wed, 10 Sep 2025 10:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1757525651;
 x=1758130451; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RMO0vq/NQLK33bM2PqMPE8lBDZVKDVsDrem760KZG/U=;
 b=EwCeDuXr+Dn5ugQz19TaRgNvfuGsMq3KOgkj9pen5x9zWQVGuju9vzgG4TFACynw1d
 cDSaUjsa4NPH5gTvgzkb8uw+TugNM6dLDqSB5E6vmujduyy0+KnDpFPduHsD38JD81Zu
 UxHQLA/01bRfDHiN6amwOEkNYk5nEBNj5PABZ8gjcArG4un52Acof2kmf/dzBxu1Gu81
 SuOauNGRboCPSIS9uQYuwXlJU2GunWyXXyPeOVoOqenZe3ni6qxDh+O9OFSI6x+G2f/e
 4KK6REYlicrsYfgro/Bjmi7XPjgzUUzJJr7mfS6Mp5Rci1Nj48UxXBM5n4Yc7e6xaTf3
 QmHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757525651; x=1758130451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RMO0vq/NQLK33bM2PqMPE8lBDZVKDVsDrem760KZG/U=;
 b=N0kZ+gPSoEgbaaKF6s5ia7sFxBL3k1mq/k2vHLFOXVI7UFA3EKnxtOaCjeXMvVFVW5
 R2wOLGFAQ9z6KvtZe27++LFCzM64ej3Y+tBD8UYdz1SVLqKCg/AzzpHZUehrEN/E+Iht
 ob+l7+ICewrDcVXvftwErNoHX55Aw1/Q2B55tqukPpi8NFD8qcpvW69q5yNi5Igx+Ib1
 u2NReCjIrGmqaGaSupR0nl/Mszhl9m/EEiQwM7TSWMbsKNhHHyGzYII2zMUxaORGaZDl
 Gi6VAUe8luGU5MSTa4IYTeka0DW4+Z/Gglpmg8JGQ5d4sRrm52bNunQMiosAMSKm78tI
 L0tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIL0nvjk7w+Gk3Z7Sez5j+UZPkoJ+bCeY930wbsc32UGD2AlxFB8Yy3Jk099HmJKjWbw8=@dpdk.org
X-Gm-Message-State: AOJu0Yy8MZYTpj34vfAuoV2cyKRAV08t0eJVraRhCfV5GYGQ0gSt1ltU
 iWWrvW5R1NGdkANBgyl6hc+qNRWhXmFoux4PUdn3ypn4e1DNr7MZuWh7NRkL4COmVC0=
X-Gm-Gg: ASbGncs8xTvcCksipwy/8WBKPD5fd35QoOnribRO0TAk1wsUjacoiJkP5Hf5KTT03LG
 YWks8I06wif+7baStD6CotLeINOEL2t9XgsMTxYq4PDpPrTmBbI5XhBNNxqqt16XxvbKeVveZeu
 UNRjy8uq3htQ8fcCTwgTFLDt7xcKKLzNfbwWqzeZjSsNL9fFVdAPu/Fu2cDmf9s0kN10iXtW7px
 eI1a5hT78IeCUBMYtUlEyemBYsGCvLCctEB9tmU51pGcJvmazvCKGQ/IsM8zNUKEjHNVpFIkf+F
 yqUn1+aCJigFaIpj82/5bmRKrFOoLTKvqDtyCHxrzxeS5NLJGPTxVBTKbhmNzlycF13whP5wVd6
 yr+vM+0dC4TYyO9xrtOPhPi4WMUvj84MrmiyBKyBgNQ+eyO+PtKPlAdic0XsLBHeAjwrFvZWp5w
 M=
X-Google-Smtp-Source: AGHT+IH2t0eqM37tSE71it3HXAZRHO8Y8HS800ebAPGtaHmnwPOcOQaIEvWFeCxdsTrBG5X4gYu5fA==
X-Received: by 2002:ac8:5d50:0:b0:4b4:8fc1:cd2b with SMTP id
 d75a77b69052e-4b5f8360730mr141267321cf.14.1757525650739; 
 Wed, 10 Sep 2025 10:34:10 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b61bbf9042sm27402041cf.53.2025.09.10.10.34.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 10:34:10 -0700 (PDT)
Date: Wed, 10 Sep 2025 10:34:06 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Cc: Aman Singh <aman.deep.singh@intel.com>, Anatoly Burakov
 <anatoly.burakov@intel.com>, Ferruh Yigit <ferruh.yigit@amd.com>, Andrew
 Rybchenko <andrew.rybchenko@oktetlabs.ru>, Ajit Khaparde
 <ajit.khaparde@broadcom.com>, Xiaoyun Li <xiaoyun.li@intel.com>,
 dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH] app/testpmd: stop secondary process fwd_lcores during
 primary teardown
Message-ID: <20250910103406.3be5eac1@hermes.local>
In-Reply-To: <20250910110237.460825-1-14pwcse1224@uetpeshawar.edu.pk>
References: <20250910110237.460825-1-14pwcse1224@uetpeshawar.edu.pk>
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

On Wed, 10 Sep 2025 04:02:37 -0700
Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk> wrote:

> +#ifndef RTE_EXEC_ENV_WINDOWS
> +			printf("Stopping secondary process ...\n");
> +			void *msg = NULL;
> +			if (rte_mempool_get(message_pool, &msg) < 0)
> +				rte_panic("Failed to get message buffer\n");
> +			strlcpy((char *)msg, "stop", STR_TOKEN_SIZE);
> +			if (rte_ring_enqueue(send_ring, msg) < 0) {
> +				printf("Failed to send message - message discarded\n");
> +				rte_mempool_put(message_pool, msg);
> +			}
> +#endif

Windows doesn't support secondary processes, not sure how you tested this.
When Windows supports secondary processes it should the existing EAL API's,
not fixing every service.
