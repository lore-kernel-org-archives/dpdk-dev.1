Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA1E1CAC58E
	for <dpdk-dev@archiver.kernel.org>; Sat, 13 Sep 2025 16:23:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A66840156;
	Sat, 13 Sep 2025 18:23:11 +0200 (CEST)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com
 [209.85.160.174])
 by mails.dpdk.org (Postfix) with ESMTP id 382284003C
 for <dev@dpdk.org>; Sat, 13 Sep 2025 18:23:10 +0200 (CEST)
Received: by mail-qt1-f174.google.com with SMTP id
 d75a77b69052e-4b60481d4baso33737771cf.2
 for <dev@dpdk.org>; Sat, 13 Sep 2025 09:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1757780589;
 x=1758385389; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zKebn7lnYCS0miBiZRvYEn41gnWX1MeeN1uizaRGEPM=;
 b=aooHVAiAQUFjx/dhz31+CRe2CMHlXCNRpHCZQK1DNhIfqjaIRADArtPOn12w9BKH90
 6htxcLQ1OPbqTUUvUfkcGTPRW/GZhyprK3ZUo572pbU9FYnXA2H9ITuuWhby+Ul3M0g5
 JRyBQ5GAH/d/zd06FKF33tldIdB3nmxH7bWrWHwGVR/0hQG1DNr2Rd3XdORjdSw7JMCC
 KnU7z2ADIOdMO3o8wpaWRALvPR+X91M0JAg54Ys9K0aPV+TT7WrL4Z07ir5r2DkZmXAm
 snocbtZOUHnXsJaOR644Woxr5suCCb9izSxTIueavt27Laxwf0fJyXKySJr1lZf5CV4V
 ZEdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757780589; x=1758385389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zKebn7lnYCS0miBiZRvYEn41gnWX1MeeN1uizaRGEPM=;
 b=JwODl2g/bylxKx26lih8PI67rKpNFo68c3amnSbpgQoLAhbsGeoBvekvuHhMxhE3CL
 eIKU0W9IOOYDaU9ABJRj6pyWSlvEU8hBRbU0gD0yMJEUvcJnFol1SeCRqJjWwe4++JeQ
 1JuM1obXv2452wrGzilX0R16FLpbE6/9BAT2UsdzEQhjpahc8C2BJDbwST/MDDyDCE97
 xm2OFuqZks+VNquOHMeep9Z/bQ0mo43iIUg+MJ728ZrROPiJ6dXDWULZS8NHa0VQ0AFS
 y/w+JVLw0+8Zd5dNh/o1QBmwxXt09sC2nfYS0Kyj9VpXvhJuyEQTnHsoKF9dsOg6vzFf
 VUYw==
X-Gm-Message-State: AOJu0Yy4kWsDRhKmZTHQBAtag5nh/Qy09y/Tt070nU11+odei5WCIIxE
 AOlcX7EcU+ZUhtxeXikM6ydiSNsN+keakfU3bbvlA16dzPJGZs7FgnGHmQEbrYpl+5Cp8ubjFcX
 NRhPXHaE=
X-Gm-Gg: ASbGncvSzgFyqnJ4Ws4+B6KwIk7sHMd8eq14xGz4x2Cepwc5y96petdJBUhsuhtNcge
 tn3CrSdZnW/7fFiGff/I61uY3jAOOWNGrwm0n2tAKsDOyupqvs0l2WrQkk0WOv0MjW9Acywj6Hb
 YweeRByb8wORfUkU/YEXpQHcDT11Il2d6HCQlPFdUL81JyXv00CwPBn0TsMh91aQwJ/hQ2lXVKz
 DQa2OvKF77PgPdpGfsx8C3zdq4I99PKzfWSqQ5rvau2raQikCWLVla45Exi1YC4Z5P0gwtAiTEu
 aU89TMfdZG8uEcgfSWpcKwQgsYK5os+QWlsAOnhlFxRkoueyLC7D5pUFZ89xgENokfzbMxa0yy1
 KeqW6QaysUpnpPlXK863ie7Sp7IGpiHXCQronWe2B8tSnXhd/2f/Ft4XBfe28A2Fr53H3mL39MW
 V05iLTfd5QAw==
X-Google-Smtp-Source: AGHT+IFgGT+X8XJjuavf2GfPiG09kkB92FJUWhEVaUFsXu/pPWh5GWXxtIxfZwfkoh8ATL6hBHV2+A==
X-Received: by 2002:ac8:7fcd:0:b0:4b0:6205:d22b with SMTP id
 d75a77b69052e-4b77d12cc31mr81957131cf.52.1757780589094; 
 Sat, 13 Sep 2025 09:23:09 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-820cd704b9bsm471886185a.44.2025.09.13.09.23.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Sep 2025 09:23:08 -0700 (PDT)
Date: Sat, 13 Sep 2025 09:23:04 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Serhii Iliushyk <sil-plv@napatech.com>
Cc: dev@dpdk.org, mko-plv@napatech.com, ckm@napatech.com
Subject: Re: [PATCH v2 1/7] net/ntnic: introduce service API for NTNIC PMD
Message-ID: <20250913092304.1ca77333@hermes.local>
In-Reply-To: <20250908141740.1312268-2-sil-plv@napatech.com>
References: <20250908110446.1071964-8-sil-plv@napatech.com>
 <20250908141740.1312268-1-sil-plv@napatech.com>
 <20250908141740.1312268-2-sil-plv@napatech.com>
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

On Mon,  8 Sep 2025 16:17:33 +0200
Serhii Iliushyk <sil-plv@napatech.com> wrote:

> diff --git a/doc/guides/nics/ntnic.rst b/doc/guides/nics/ntnic.rst
> index b3d6ad70c1..a173eaa2ac 100644
> --- a/doc/guides/nics/ntnic.rst
> +++ b/doc/guides/nics/ntnic.rst
> @@ -185,3 +185,115 @@ There are list of characteristics that age timeout action has:
>  - after flow is aged-out it's not automatically deleted;
>  - aged-out flow can be updated with ``flow update`` command,
>    and its aged-out status will be reverted;
> +
> +Service API
> +-----------
> +
> +**nthw_service_add**
> +**nthw_service_del**
> +**nthw_service_get_info**
> +
> +The NTNIC PMD provides a service API that allows applications to configure services
> +
> +The services are responsible for handling the vital functionality of the NTNIC PMD:
> +
> +- **FLM Update**: is responsible for creating and destroying flows;
> +- **Statistics**: is responsible for collecting statistics;
> +- **Port event**: is responsible for handling port events: aging, port load, and flow load;
> +- **Adapter monitor** is responsible for link control;
> +
> +**NOTE**: Use next EAL options to configure set service cores
> +   * -s SERVICE COREMASK Hexadecimal bitmask of cores to be used as service cores;
> +   * -S SERVICE CORELIST List of cores to run services on;
> +
> +**NOTE**: **At least 5 lcores must be reserved** for the ntnic services by EAL options. above.
> +
> +For example
> +
> +.. code-block:: console
> +
> +   dpdk-testpmd -S 8,9,10,11,12
> +
> +The PMD registers each service during initialization by function:
> +
> +.. code-block:: c
> +
> +   int nthw_service_add(struct rte_service_spec *srv_spec, const enum rte_ntnic_service_tag tag)
> +
> +and unregistered by the PMD during deinitialization by the function:
> +
> +.. code-block:: c
> +
> +   int nthw_service_del(const enum rte_ntnic_service_tag tag)
> +
> +The service info may be retrieved by function:
> +
> +.. code-block:: c
> +
> +   struct nt_service *nthw_service_get_info(const enum rte_ntnic_service_tag tag)
> +
> +The service info includes the service ID, assigned lcore, and initialization state.
> +
> +Service API for user applications
> +---------------------------------
> +**rte_pmd_ntnic_service_set_lcore**
> +**rte_pmd_ntnic_service_get_id**
> +
> +The exported service API is available for applications to configure the services.
> +
> +By API function:
> +
> +.. code-block:: c
> +
> +   int rte_pmd_ntnic_service_set_lcore(enum rte_ntnic_service_tag tag, uint32_t lcore_id)
> +
> +For example to assign lcores 8,9,10,11,12 to the services, the application can use:
> +
> +.. code-block:: c
> +
> +   rte_pmd_ntnic_service_set_lcore(RTE_NTNIC_SERVICE_STAT, 8);
> +   rte_pmd_ntnic_service_set_lcore(RTE_NTNIC_SERVICE_ADAPTER_MON, 9);
> +   rte_pmd_ntnic_service_set_lcore(RTE_NTNIC_SERVICE_PORT_0_EVENT, 10);
> +   rte_pmd_ntnic_service_set_lcore(RTE_NTNIC_SERVICE_PORT_1_EVENT,11);
> +   rte_pmd_ntnic_service_set_lcore(RTE_NTNIC_SERVICE_FLM_UPDATE, 12);
> +
> +The API will automatically lcore to service core list and map the service to the lcore.
> +
> +.. note:: Use `rte_service_lcore_start` to start the lcore after mapping it to the service.
> +
> +Each service has its own tag to identify it.
> +
> +.. code-block:: c
> +
> +   enum rte_ntnic_service_tag {
> +      RTE_NTNIC_SERVICE_FLM_UPDATE = 0,
> +      RTE_NTNIC_SERVICE_STAT = 1,
> +      RTE_NTNIC_SERVICE_PORT_0_EVENT = 2,
> +      RTE_NTNIC_SERVICE_PORT_1_EVENT = 3,
> +      RTE_NTNIC_SERVICE_ADAPTER_MON = 4,
> +      RTE_NTNIC_SERVICE_MAX
> +   };
> +
> +The application may use next API function to retrieve the service id:
> +
> +.. code-block:: c
> +
> +  int rte_pmd_ntnic_service_get_id(enum rte_ntnic_service_tag tag);
> +
> +
> +For example, to enable statistics for flm_update service, the application can use:
> +
> +.. code-block:: c
> +
> +   int flm_update_id = rte_pmd_ntnic_service_get_id(RTE_NTNIC_SERVICE_FLM_UPDATE);
> +   rte_service_set_stats_enable(flm_update_id, 1);
> +
> +All other manipulations with the service can be done with the service ID and rte_service* API.
> +
> +To use the service API, an application must have included the header file:
> +
> +.. code-block:: c
> +
> +   #include <rte_pmd_ntnic.h>
> +
> +And linked with the library: `librte_net_ntnic.so` or `librte_net_ntnic.a` for static linking.

It is not clear what happens if application does not use the driver API?
What happens "out of the box" with OVS and VPP?

The fact that it requires special driver API's shows that there is a missing
feature in the service lcore library. Should be able to do this stuff through that
API. But that is not your problem, and doesn't need solving in this set.
