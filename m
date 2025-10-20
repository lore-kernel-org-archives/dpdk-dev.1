Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A987CCD19F
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 21:17:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3300240262;
	Mon, 20 Oct 2025 23:17:39 +0200 (CEST)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id 04CB340151
 for <dev@dpdk.org>; Mon, 20 Oct 2025 23:17:37 +0200 (CEST)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-27ee41e0798so76876155ad.1
 for <dev@dpdk.org>; Mon, 20 Oct 2025 14:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760995057;
 x=1761599857; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a4C7TX2018jtiglOXs1PpRTuZQuc2Zp/AOAmuDZAZKw=;
 b=EvTiJvHgZESS1fSAh5+pIvhJ3MgqeiabljcV5Uwd+UOdnWw19t7lqy57PD4GJ6JZu1
 zmkigZ5miFp5bwAwmsghUNzJ4bZhRPqFAEf+IjFnlMrC6j7RvahkVhGublLAeoVzFZ0A
 SUPW0SRJFRJVNWK83R5g240OIoPU1jomzmpB2zMlxjFD7ka0TAD1L3JRCru/bh+1yQ4B
 95OHMG/fzjptmoeU3XTKNpXSenG4jY+SaDLH4y9+ohv46vWRqam647PYgbuqltvIjldh
 jEm487YaMN47WlsCNV+hCu2XPlRyU/r3eEWQO2Sx84osJarYflP32WidgkYl6CrqGWFb
 TX0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760995057; x=1761599857;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a4C7TX2018jtiglOXs1PpRTuZQuc2Zp/AOAmuDZAZKw=;
 b=s+gm/5VzvigA3Uz2OM2GlUw8M9VEcO+a5KqFEQpK0Y+XtZ/ivyj6bKuhjEoy0qasIS
 4YFNgnR9zr78UITu4j0kx9M4lm1DHCtAvx4lKG7gnc/+uTGf81eZGsb7ytto0PYKeppO
 a7YzXgu6bJwT/ur8pBAqs27Fl3wNw/Mwmb3OihTL64F2wMjlBBSHTZwkCxXl0fTBLGoC
 sRoERNUUaLAncJcnOp4otsxeMka3eP+kH8VFAfO3CFetizsOnwYydjxP5/yhvQ499rpW
 vJcIW5bHOhZHybANXlTVda2+VVxVZ2GqrRuvfmphg3CP4QkO3d7T1xzs9LUG3hcNUWh1
 2Edg==
X-Gm-Message-State: AOJu0YyyURdAYmrK7BaYFSiEygmzs1qUCX0nEfuSADOwiOAd1Fe1fWDs
 Yxi3CJhapmrupiEyotPXQ3HOJ3jC8jwaNdsZysLqTBmVrTzLhRdjLKdS/WPoFp4AnLd7paR3bTH
 /G2HcnP82+g==
X-Gm-Gg: ASbGnct+sJ+FuGicaqtHH8yT9LkCG8t1KMbkHxa9bntoytZIEaucHiRfK3bOFo09Cus
 1ojY/v/qVH58LvCKhmyShtyfedJghoeaHamLZ8cdqbWfiI++0Z7LE0q4k8CafjJO/+zo9QnAWMe
 42WDscbRJp9ApFM6lb6U3hwd3fzQbWC861Y64JAh9RZx/l+yjkaxOzgN1VZ8jr4TF1qhrjxk51l
 bRbfnVMZBz5HeLvlqwiallTWKTt/ODl2so0xoslO1YTn41JXfkrmrTPcrdk6BO46+lFsTBgxzwq
 tyfwJ8ZHv4t6F/N0uO97YOwBJj/3AAgNCkBvP/GZfOihgT63AOhwbTZS8xbD8xQ3XYiyt/S7kyE
 i8doiVvyTSoO5MSH1Pllz3wm8VR2VeD1NF6n7DeAk5iTAh1VbJv8f9RfeX8HUnvHAbdOsaX2wiY
 hvVkI+8iFl/AY34wpFFz8eJ24n3F+NEEh+wSwU9fjZtvmXh7o+lQ==
X-Google-Smtp-Source: AGHT+IHXWWW6sRdWYbF9eOIoiIjB1EJvLQPt2njwl8dlOO9xzxv2MwrwJicWUBgRSxIS5a4MpJFaUA==
X-Received: by 2002:a17:902:d492:b0:25d:1640:1d59 with SMTP id
 d9443c01a7336-290c9cf8e12mr154920845ad.8.1760995056769; 
 Mon, 20 Oct 2025 14:17:36 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-292471fdcf9sm88894935ad.91.2025.10.20.14.17.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Oct 2025 14:17:36 -0700 (PDT)
Date: Mon, 20 Oct 2025 14:17:34 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Serhii Iliushyk <sil-plv@napatech.com>
Cc: dev@dpdk.org, mko-plv@napatech.com, ckm@napatech.com
Subject: Re: [PATCH v1 00/24] Migrate threads to the DPDK service framework
 and refactor naming for exported symbols
Message-ID: <20251020141734.6f05bc69@phoenix.lan>
In-Reply-To: <20251020163620.282312-1-sil-plv@napatech.com>
References: <20250908141740.1312268-2-sil-plv@napatech.com>
 <20251020163620.282312-1-sil-plv@napatech.com>
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

On Mon, 20 Oct 2025 18:35:51 +0200
Serhii Iliushyk <sil-plv@napatech.com> wrote:

> This modification provides better resource (CPU) management for NTNIC PMD.
> 
> The following threads are migrated:
>         * FLM update thread
>         * Statistic thread
>         * Port event thread
>         * Adapter monitoring thread
> Additionally, a warning is added to inform users about the importance of
> dedicating lcores to the DPDK service framework when using the NTNIC PMD.
> The code is also cleaned up to use pthreads and rte_thread APIs.
> 
> After this patch series, an each application using NTNIC PMD should
> dedicate at least five(5) cores for DPDK service framework to ensure
> proper operation of the NTNIC PMD.
> 
> The service cores can be dedicated by EAL options:
>         * s SERVICE COREMASK Hexadecimal bitmask of cores to be used as service cores
>         * S SERVICE CORELIST List of cores to run services on
> Or with a special API by the application itself.
>         * rte_pmd_ntnic_service_set_lcore to map a service to a specific lcore
>         * rte_pmd_ntnic_service_get_id to get a service ID.
> 
> This patch series also includes aligning the naming of the exported symbols to avoid
> potential conflicts with other applications and libraries.
> The main change is to add the prefix "nthw_".

I assume you meant v3 not v1 here.
