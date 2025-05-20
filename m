Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8091C3DA6D
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 May 2025 13:53:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB9A540674;
	Tue, 20 May 2025 15:53:35 +0200 (CEST)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mails.dpdk.org (Postfix) with ESMTP id 055B5402AE
 for <dev@dpdk.org>; Tue, 20 May 2025 15:53:34 +0200 (CEST)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-23229fdaff4so30571865ad.1
 for <dev@dpdk.org>; Tue, 20 May 2025 06:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1747749213;
 x=1748354013; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=681cDogw+E54E6DKnSavIZSBjehMh2e+NMFEhEJNEyY=;
 b=tR875tnbNcPE/3fYfXx7vwB8zOM1yT7FiYs+31/Tdq1hfv80B9HBC6bRW3n5HZVvZJ
 Yfj3/l12vZhvc1qpO0xvj3OrVzsOo7cM/Oiv7YqefI+Hkre1O6MA4FcRDMXlXmjA+Zcu
 UaqtZWFx6rJ29vvUv/ResG4JF4E1u5cEMOVzjZq2bnkuW74Zpn523a0F+tvRxgk/vFOZ
 J9xWBxM+LDk4yo1Y4hmK86VkZ07P3KU4oIYLXf0mP5feTaCVJl3YtPr3wmjERKwPszqM
 ce6ORVZg1vfoS625P66QVRiK2+uwwbHwD1tYY+H4Brjgx1xRxD0P7AKtzIpdeqL33t/V
 fhBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747749213; x=1748354013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=681cDogw+E54E6DKnSavIZSBjehMh2e+NMFEhEJNEyY=;
 b=j1AWtf7N8klDdCeDfiaGF56QmH+6YngIMUrlIbMnR9lIBN83tOJ3aXwSpvZPJtRA4R
 T0qjKnwSr0IcoSqiBrFnLUdAvIPrGaBN/J9tM4DqeCAlq/6FLJitbdJ0NR3KZhOlHgVa
 8hLwQsZzOqXgzxPzkWEEv3Y3RVw30m2pj1d4XuydtbtpEh1/Mm9ea1ZbDcHs50U0Y6Ma
 8STDXk5r1tGaZFFBPvca+anaabUYOBCulcSO6BBTjlyPTBfaTv2O+V4121s2asoqJros
 QRs1Yq1mamC7J9IH2nxO/+s5Q+IghW0Koe83EEIcdOawAODH/828BbZv1Yfl++BFM0FV
 5e6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW00PWmF94RnTN5Qo99uOwEfz1FMO/FHsQzGqJVJLCYoLn5dvDT8RIOcHbmhaswifL6fuk=@dpdk.org
X-Gm-Message-State: AOJu0YzErHvzsMpFXJKkw82jMPjoCwHIExc8qzcY/oURw4Xx30z31/3i
 e7Kp+BtSFCTqlGt9TnHsYWGh75ZUobzsq8VC+K8pJ0Aia/2nNuYHx1EAXWu3GUqN5P4=
X-Gm-Gg: ASbGncub26EC2qAflNrWewQBMStFuQbEJHEtcdwbRs76l+UtG77ddx6eBgClMDe+zW7
 9HKYBaVQhig/TKGtQiGKxkk8uUg5DfsOwXfGGrvYodSiJcGDiADqnUwFTEHKEZylbM0bnsI/yEo
 rsQ5CWZg0iMqXuZFVZaARSe5+TVVrb3fjbIpsKbtJ9slzqqrubFs9/b84cmBHIJ766tisaIIHvb
 OdSnIh6aDsVSpVor9f1xrnl+/tZEuC+QJQC1CjAe8PZskS+U87pl6Wbpsgns8i28qntTlNIuVHf
 nlhGyxBvoAb2bJzQ0WPkABEZ53o6ysOScsFdJXenPPeBhWMd6phZ31w6wWhnKkdyqxtkYbwBW+L
 uAqN31rC05OMVRY5I+hAoSoEHj+zcZ5ADX4a52g==
X-Google-Smtp-Source: AGHT+IG82GqLlctqlrZ6kPfjG3eoCqrm25pC+LjZOpi1fwAUUViCU9ABcBzbIkx0VOoGca9zoVIzng==
X-Received: by 2002:a17:903:2692:b0:232:2af:8569 with SMTP id
 d9443c01a7336-23202af8833mr122519425ad.18.1747749212952; 
 Tue, 20 May 2025 06:53:32 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4e980e7sm77091575ad.108.2025.05.20.06.53.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 06:53:32 -0700 (PDT)
Date: Tue, 20 May 2025 06:53:28 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Wathsala Vithanage <wathsala.vithanage@arm.com>
Cc: Thomas Monjalon <thomas@monjalon.net>, Ferruh Yigit
 <ferruh.yigit@amd.com>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 dev@dpdk.org, Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>, Dhruv
 Tripathi <dhruv.tripathi@arm.com>
Subject: Re: [RFC PATCH v4 3/3] ethdev: introduce the cache stashing hints API
Message-ID: <20250520065328.479b8c73@hermes.local>
In-Reply-To: <20250517151736.2565461-4-wathsala.vithanage@arm.com>
References: <20241021015246.304431-1-wathsala.vithanage@arm.com>
 <20250517151736.2565461-1-wathsala.vithanage@arm.com>
 <20250517151736.2565461-4-wathsala.vithanage@arm.com>
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

On Sat, 17 May 2025 15:17:35 +0000
Wathsala Vithanage <wathsala.vithanage@arm.com> wrote:

> Extend the ethdev library to enable the stashing of different data
> objects, such as the ones listed below, into CPU caches directly
> from the NIC.
>=20
> - Rx/Tx queue descriptors
> - Rx packets
> - Packet headers
> - packet payloads
> - Data of a packet at an offset from the start of the packet
>=20
> The APIs are designed in a hardware/vendor agnostic manner such that
> supporting PMDs could use any capabilities available in the underlying
> hardware for fine-grained stashing of data objects into a CPU cache
>=20
> The API provides an interface to query the availability of stashing
> capabilities, i.e., platform/NIC support, stashable object types, etc,
> via the rte_eth_dev_stashing_capabilities_get interface.
>=20
> The function pair rte_eth_dev_stashing_rx_config_set and
> rte_eth_dev_stashing_tx_config_set sets the stashing hint (the CPU,=C2=A0
> cache level, and data object types) on the Rx and Tx queues.
>=20
> PMDs that support stashing must register their implementations with the
> following eth_dev_ops callbacks, which are invoked by the ethdev
> functions listed above.
>=20
> - stashing_capabilities_get
> - stashing_rx_hints_set
> - stashing_tx_hints_set
>=20
> Signed-off-by: Wathsala Vithanage <wathsala.vithanage@arm.com>
> Reviewed-by: Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>
> Reviewed-by: Dhruv Tripathi <dhruv.tripathi@arm.com>

Adding more control in DPDK is good but I have concerns.

The default must be that the application has all the caching enabled
without calling this API. It would be bad if existing DPDK applications
from network vendors had to be modified.

The DPDK should follow the "it just works" mantra and additional
API's should be for special cases.
