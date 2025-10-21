Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB56CCD184
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 15:12:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52F324066F;
	Tue, 21 Oct 2025 17:12:34 +0200 (CEST)
Received: from fout-b8-smtp.messagingengine.com
 (fout-b8-smtp.messagingengine.com [202.12.124.151])
 by mails.dpdk.org (Postfix) with ESMTP id 1887A4066D
 for <dev@dpdk.org>; Tue, 21 Oct 2025 17:12:32 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id 390111D000BF;
 Tue, 21 Oct 2025 11:12:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Tue, 21 Oct 2025 11:12:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1761059551;
 x=1761145951; bh=Wa0JrKrOMm7sGm4qxAjJ/1cRi4vPuDkMgwTIlPFqYbQ=; b=
 C2H9wWk18WiVvYEyEnhEtcPA8scnrasTgrt8QPmxRW2DnL1ZMxjhKmDaIlFJlG0v
 eqVzaBi2+/86VHlFyJ+RH0eNmbTr0KCGWHqN9rNTvkrQrxz6WKk74fN/wg+SFTpR
 u0VhgxEnTJSmF+w6m/wZPReGNVYOuMMDea2GvU/5hrg8p+jaWHJiq+nru9CmHYYQ
 hbxVxOEydMp0ONrg9wAs2XwmMScgk/yca5HXJkD+HdYvmuh+8p2BqeNpm+VtHrZi
 secvf1DWPfX44c/8+mY3i44k3Ovnx3uiYwHarzxJ/i98EODNvZU7khjvtf0AoUOK
 nrY5eSofyJd9WBl/6X7TSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761059551; x=
 1761145951; bh=Wa0JrKrOMm7sGm4qxAjJ/1cRi4vPuDkMgwTIlPFqYbQ=; b=K
 t9Tj3MguTc0s0Gwn7h2l5P3BC0lPSDLAoq6jRDIqqozsn7GDM4hzKAb93YnW+zfL
 HCaMH1Tg4CvGAEbPYnQnjnFYiskm0ruGBsfl+3sfRW6ucmC1oKLFCeIggfjFoZw0
 ApflEGFgkERTGN4f+t+OiTaik87OGeS9L2EIFPeO1EGYE3wQPVWfwG1bpPBkPEX8
 RQHFpvNHAupIQ6YljtLFyJtHAthoMKdEkJIVQZ19pWuC3UVJchyd4NTd0W3fsn8o
 ROWjY9QMtarXJlCpggdVnsgY6LdEnzmiu3MlBjgEa/RP+iDw6MWc7rc27GxGYbhe
 uqXSO/+JAxzj8LKYVgYYw==
X-ME-Sender: <xms:3qL3aP9sO57wZKb5OhNbc6BWGof8cIWD4qQZ6BuTlNkq8QNUzP7xsw>
 <xme:3qL3aErcSmTMSyNt4xTDVSdCaR-zxkN27SMH3Sm2FlT4qt60kDwWj-DjTx3hqlNmT
 1QQO-2FnWrXZvNlARW01XeVhUuJxmvFFpjuATSgjh8bgR6Kz88zFQ>
X-ME-Received: <xmr:3qL3aImPO4x8RT2KJ5kytGCpKbbG_LcUeKIxpF_Kdta_ai3CwiCcxtd6Ppdoy4VCw7tGv3rut_sIpFo1dONhBVxPQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedutddvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertd
 dttdejnecuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehm
 ohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevff
 fgtdegkeeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgep
 tdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnh
 gvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
 shhilhdqphhlvhesnhgrphgrthgvtghhrdgtohhmpdhrtghpthhtohepuggvvhesughpug
 hkrdhorhhgpdhrtghpthhtohepmhhkohdqphhlvhesnhgrphgrthgvtghhrdgtohhmpdhr
 tghpthhtoheptghkmhesnhgrphgrthgvtghhrdgtohhmpdhrtghpthhtohepshhtvghphh
 gvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhg
X-ME-Proxy: <xmx:3qL3aLh0DlD3CeoQhU68udyLA3oD8m5E8tORKhCiPSi4rdIOvWsHyg>
 <xmx:3qL3aAddaIVyTCZs-hrD5wiVT7lIwWBbGGCPLf-fTriiGUpm2rUc9A>
 <xmx:3qL3aLhVZUm6zlKeeUnsoWg9quJI_PnFlfKomC55yq9u7roTS_63Rw>
 <xmx:3qL3aIyePkcOrwEXec12j5SWoa_7LS_M7nojGuaeql9DYtJgx1995A>
 <xmx:36L3aLJp_7LQ7Cizc80J7xLSdle2Mz-XjQDEv5XcV3Ux6FoheohM6s2E>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 11:12:29 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Serhii Iliushyk <sil-plv@napatech.com>
Cc: dev@dpdk.org, mko-plv@napatech.com, sil-plv@napatech.com,
 ckm@napatech.com, stephen@networkplumber.org
Subject: Re: [PATCH v1 01/24] net/ntnic: introduce service API for NTNIC PMD
Date: Tue, 21 Oct 2025 17:12:27 +0200
Message-ID: <9256303.5OynTdThKG@thomas>
In-Reply-To: <20251020163620.282312-2-sil-plv@napatech.com>
References: <20250908141740.1312268-2-sil-plv@napatech.com>
 <20251020163620.282312-1-sil-plv@napatech.com>
 <20251020163620.282312-2-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

20/10/2025 18:35, Serhii Iliushyk:
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


This doc is a real mess considering formatting.
I suppose you didn't read it twice and never tried to generate HTML output.
I'll do a quick cleanup while pulling in the main branch.


